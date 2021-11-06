# python -m pip install --upgrade pip
# pip install azure-storage-file-share
# Create a storage account

from azure.storage.fileshare import ShareServiceClient
from azure.storage.fileshare import ShareFileClient
from azure.storage.fileshare import ShareDirectoryClient


def get_connectionstring():
    row = None
    with open("az_storage_py_con_str.txt", "r") as r:
        row = r.readline()
    return str(row)
# Types of credentials
# https://docs.microsoft.com/en-us/azure/storage/common/authorize-data-access
connection_string = get_connectionstring()
service = ShareServiceClient.from_connection_string(conn_str=connection_string)

# Listing contents of a directory
parent_dir = ShareDirectoryClient.from_connection_string(conn_str=connection_string, share_name="testit3fs", directory_path="testdir")

my_list = list(parent_dir.list_directories_and_files())
size = str(len(my_list))
print("Items: " + size)
ty = type(my_list[0])
print(ty)

# Iterate over list items
for l in my_list:
# get key, value for item
    for k, v in l.items():
        if k.lower() == "name" or k.lower() == "size":
            print(str(k) + ", " + str(v))


# Uploading a file
file_client = ShareFileClient.from_connection_string(conn_str=connection_string, share_name="testit3fs", file_path="testdir/az_local_file.txt")

with open("az_local_file.txt", "rb") as source_file:
    rv = file_client.upload_file(source_file)
    print(rv)








