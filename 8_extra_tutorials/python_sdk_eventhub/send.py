# https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-python-get-started-send

# pip install azure-eventhub
# pip install azure-eventhub-checkpointstoreblob-aio
# Create an Event Hubs namespace and an event hub (portal)

# HOW TO EVENT HUB
# https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-create

# 1 Create RG + Create an Event Hubs namespace
# 2 Create an event hub
# 3 Connection string for a specific event hub in a namespace
# 3.1 Select the event hub->
# 3.2 SAS-> Create a policy with Manage, **Send, or Listen access->
# 3.3 When created get the Connection string-primary key field

import asyncio
from azure.eventhub.aio import EventHubProducerClient
from azure.eventhub import EventData

def get_event_hub_con():
    row = ""
    try:
        with open("az_event_con_str.txt", "r") as r:
                row = r.readline()
    
    except FileNotFoundError as file_error:
            print(file_error)
    return str(row)

info = get_event_hub_con()
# print(info)

# Send events
async def run():
    # Create a producer client to send messages to the event hub.
    # Specify a connection string to your event hubs namespace and
    # the event hub name.                                             Connection string–primary key       EventHub name
    producer = EventHubProducerClient.from_connection_string(conn_str=get_event_hub_con(), eventhub_name="testit4hub")
    async with producer:
        # Create a batch.
        event_data_batch = await producer.create_batch()

        # Add events to the batch.
        event_data_batch.add(EventData('First event '))
        event_data_batch.add(EventData('Second event'))
        event_data_batch.add(EventData('Third event'))

        # Send the batch of events to the event hub.
        print("Messages sent to event hub success")
        await producer.send_batch(event_data_batch)

loop = asyncio.get_event_loop()
loop.run_until_complete(run())
