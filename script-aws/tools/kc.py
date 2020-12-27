import sys
import boto3
from botocore.exceptions import ClientError
import json
from datetime import datetime
import time

streamName = sys.argv[1]
regionName = "us-east-1"
print "stream: {} ({})".format(streamName, regionName)

RETRY_EXCEPTIONS = ('ProvisionedThroughputExceededException', 'ThrottlingException')

kinesis_client = boto3.client('kinesis', regionName=regionName)
response = kinesis_client.describe_stream(StreamName=streamName)

# retrieve the id of the first shard
shardId = response['StreamDescription']['Shards'][0]['ShardId']
print "shardId: {}\n".format(shardId)

shardIteratorResponse = kinesis_client.get_shard_iterator(StreamName=streamName, ShardId=shardId, ShardIteratorType='LATEST')

shardIterator = shardIteratorResponse['ShardIterator']
recordResponse = kinesis_client.get_records(ShardIterator=shardIterator, Limit=2)

count = 0
while 'NextShardIterator' in recordResponse:
	try:
		recordResponse = kinesis_client.get_records(ShardIterator=recordResponse['NextShardIterator'], Limit=2)
		if len(recordResponse['Records']) > 0:
		    for item in recordResponse['Records']:
          count = count + 1
          print("count: {}".format(count))
			print "{}\n".format(item['Data'])
		time.sleep(1)
	except ClientError as err:
		if err.response['Error']['Code'] not in RETRY_EXCEPTIONS:
			raise
		print('WHOA, too fast, slow it down')
		time.sleep(2)
