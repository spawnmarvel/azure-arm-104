# https://pypi.org/project/azure-storage-queue/#receiving-messages
# pip install azure-storage-queue

# Clients Two different clients are provided to interact with the various components of the Queue Service:
# 1 QueueServiceClient
from urllib import response
from azure.storage.queue import QueueServiceClient
# 2 QueueClient
from azure.storage.queue import QueueClient
# https://docs.microsoft.com/nb-no/python/api/azure-storage-queue/azure.storage.queue.queueclient?view=azure-python
from datetime import datetime as dt

class QueueUtilityWorker:

    def __init__(self) -> None:
        self.access_key = None
        self.acc_url = "https://testit3straccount.queue.core.windows.net"
        self.file_exist = False
        self.connection_status = False
        try:
            with open("az_storage_key.txt", "r") as r:
                row = r.readline()
                self.access_key = row
                self.file_exist = True
        except FileNotFoundError as file_error:
            print(file_error)

    # https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/storage/azure-storage-queue/samples/queue_samples_authentication.py

    # QueueServiceClient - this client represents interaction with the Azure storage account itself, and allows you to acquire preconfigured client 
    # instances to access the queues within. It provides operations to retrieve and configure 
    # the account properties as well as list, create, and delete queues within the account. 
    # To perform operations on a specific queue, retrieve a client using the get_queue_client method.
    def authentication_by_shared_key_service(self):
        queue_service_client = None
        if self.file_exist:
            try:
                # Instantiate a QueueServiceClient using a shared access key
                queue_service_client = QueueServiceClient(account_url=self.acc_url, credential=self.access_key)
                # Get information for the Queue Service
                properties = queue_service_client.get_service_properties()
                print(properties)
            except Exception as ex:
                print(ex)
        else:
            pass
        return queue_service_client  
    
    def list_all_queues_service(self):
        try:
            queue_service_client = self.authentication_by_shared_key_service()
            # list all the queues in the service
            list_queue = queue_service_client.list_queues()
            for queue in list_queue:
                   print(queue)
        except Exception as ex:
            print(ex)

    # QueueClient - this client represents interaction with a specific queue (which need not exist yet). 
    # It provides operations to create, delete, or configure a queue and includes operations to send, receive,
    # peek, delete, and update messages within it.
    def authentication_by_shared_key(self):
        queue = None
        if self.file_exist:
            try:
                # Instantiate a QueueServiceClient using a shared access key
                # QueueClient(account_url: str, queue_name: str, credential: Optional[Any] = None, **kwargs: Any)
                queue = QueueClient(account_url=self.acc_url, queue_name="explorerqueue", credential=self.access_key)
               
            except Exception as ex:
                print(ex)
        else:
            pass
        return queue


    def send_msg(self):
        try:
            queue = self.authentication_by_shared_key()
            # send some msg
            random_msg = ""
            for x in range(2):
                random_msg = "msg " + str(x) + " at time " + str(dt.now())
                queue.send_message(random_msg)
                print("Success insert " + str(x))
        except Exception as ex:
            print(ex)

    def read_msg_in_batches(self):
        try:
            queue = self.authentication_by_shared_key()
            # Receive and process messages in batches
            response = queue.receive_messages(messages_per_page=2)
            for message_batch in response.by_page():
                for msg in message_batch:
                    print(msg.content)
                    queue.delete_message(msg)
                print("Next batch....")

        except Exception as ex:
            print(ex)

   

def main():
    worker = QueueUtilityWorker()
    worker.list_all_queues_service()
    worker.send_msg()
    # worker.read_msg_in_batches()


if __name__ == "__main__":
    main()


