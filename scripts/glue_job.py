import sys
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.dynamicframe import DynamicFrame
from awsglue.utils import getResolvedOptions
from awsglue.job import Job
from pyspark.sql.functions import col, regexp_replace, upper, when

args = getResolvedOptions(
    sys.argv, ["JOB_NAME", "DATABASE_NAME", "TABLE_NAME", "TARGET_BUCKET"]
)

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

DATABASE_NAME = args["DATABASE_NAME"]
TABLE_NAME = args["TABLE_NAME"]
TARGET_BUCKET = args["TARGET_BUCKET"]

dyframe = glueContext.create_dynamic_frame.from_catalog(
    database=DATABASE_NAME, table_name=TABLE_NAME, transformation_ctx="s3files"
)

dataframe = dyframe.toDF()

if dataframe.head(1):

    transformed_df = (
        dataframe.withColumn(
            "order_id",
            when(
                col("order_id.long").isNotNull(), col("order_id.long").cast("string")
            ).otherwise(regexp_replace(col("order_id.string"), "#", "")),
        )
        .withColumn("customer_name", upper(col("customer_name")))
        .withColumn("customer_dob", regexp_replace(col("customer_dob"), "/", "-"))
        .withColumn(
            "customer_gender",
            when(col("customer_gender") == "F", "FEMALE")
            .when(col("customer_gender") == "M", "MALE")
            .otherwise(col("customer_gender")),
        )
        .withColumn("order_date", regexp_replace(col("order_date"), "/", "-"))
    )

    transformed_dyframe = DynamicFrame.fromDF(
        transformed_df, glueContext, "transformed_dyframe"
    )

    glueContext.write_dynamic_frame.from_options(
        frame=transformed_dyframe,
        connection_type="s3",
        connection_options={"path": TARGET_BUCKET},
        format="parquet",
    )

job.commit()
