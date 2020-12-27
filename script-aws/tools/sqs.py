import sys, time
import boto3

count = 0

# queue name
queueName = sys.argv[1]
#regionName = us-east-1

# create a boto3 client
# client = boto3.client('sqs', region_name=regionName)

client = boto3.client('sqs')
queues = client.list_queues(QueueNamePrefix=queueName) # we filter to narrow down the list
queueUrl = queues['QueueUrls'][0]
while True:
    messages = client.receive_message(QueueUrl=queueUrl, MaxNumberOfMessages=10) # adjust MaxNumberOfMessages if needed
    if 'Messages' in messages: # when the queue is exhausted, the response dict contains no 'Messages' key
        for message in messages['Messages']: # 'Messages' is a list
            # process the messages
            count = count + 1
            print("item[{}]: {}".format(count, message['Body']))
            # next, we delete the message from the queue so no one else will process it again
            client.delete_message(QueueUrl=queueUrl, ReceiptHandle=message['ReceiptHandle'])
    else:
        print("* {} is empty".format(queueUrl))
        time.sleep(5)
