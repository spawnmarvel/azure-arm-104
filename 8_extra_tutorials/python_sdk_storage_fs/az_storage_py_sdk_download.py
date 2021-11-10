
# https://docs.microsoft.com/en-us/azure/storage/files/storage-python-how-to-use-file-storage?tabs=python
# pip install azure-storage-file-share
# pip install aiohttp


from datetime import datetime as dt
import aiohttp
import asyncio
from azure.storage.fileshare.aio import ShareFileClient as aio_ShareFileClient


def get_connection_string():
    connection_string = None
    try:
        with open("az_storage_py_con_str.txt", "r") as r:
            row = r.readline()
            connection_string = row
    except FileNotFoundError as file_error:
        print(file_error)
    return connection_string


async def fs_download_file():
    """ Download a file from file share """
    file_client = aio_ShareFileClient.from_connection_string(
        conn_str=get_connection_string(), share_name="testit3fs", file_path="testdir/lorem.txt")
    with open("lorem_local.txt", "wb") as file_handle:
        data = await file_client.download_file()
        await data.readinto(file_handle)


async def main():
    print("\nStart: " + str(dt.now()))
    task = asyncio.create_task(fs_download_file())
    await task
    print("End: " + str(dt.now()))

asyncio.run(main())
