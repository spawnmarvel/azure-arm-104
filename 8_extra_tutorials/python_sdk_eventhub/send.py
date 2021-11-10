# https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-python-get-started-send
# pip install azure-eventhub
# Create an Event Hubs namespace and an event hub (portal)

import asyncio
from azure.eventhub.aio import EventHubProducerClient
from azure.eventhub import EventData

def get_event_hub_con():
    rv = ""
    try:
        with open("az_event_hub_con.txt", "r") as r:
                row = r.readline()
                rv = row
    
    except FileNotFoundError as file_error:
            print(file_error)
    return str(rv)

na = get_event_hub_con()
print(na)

async def run():
    # Create a producer client to send messages to the event hub.
    # Specify a connection string to your event hubs namespace and
    # the event hub name.
    producer = EventHubProducerClient.from_connection_string(conn_str=get_event_hub_con(), eventhub_name="testit4eventhub")
    async with producer:
        # Create a batch.
        event_data_batch = await producer.create_batch()

        # Add events to the batch.
        event_data_batch.add(EventData('First event '))
        event_data_batch.add(EventData('Second event'))
        event_data_batch.add(EventData('Third event'))

        # Send the batch of events to the event hub.
        await producer.send_batch(event_data_batch)

loop = asyncio.get_event_loop()
loop.run_until_complete(run())