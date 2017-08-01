import boto3
import time

session = boto3.Session(profile_name='pythonplot.com')
client = session.client('cloudfront')

response = client.create_invalidation(
    DistributionId='E1ZAZAX2AMK9LZ',
    InvalidationBatch={
        'Paths': {
            'Quantity': 1,
            'Items': [
                '/*'
            ]
        },
        'CallerReference': str(time.time())
    }
)
print(response)
