# python -m pip install --upgrade pip
# pip install azure-storage-file-share
# Create a storage account

from azure.storage.fileshare import ShareServiceClient
from azure.storage.fileshare import ShareFileClient
from azure.storage.fileshare import ShareDirectoryClient


class FilShareUtilityWorker:

    def __init__(self) -> None:
        self.connection_string = None
        self.fs_share = "testit3fs"
        self.file_exist = False
        self.connection_status = False
        try:
            # secure this in keyvault
            with open("az_storage_con_str.txt", "r") as r:
                row = r.readline()
                self.connection_string = row
                self.file_exist = True
        except FileNotFoundError as file_error:
            print(file_error)

     # TODO
    def fs_create_file_share():
        """ Used existing fs in portal for this test """
        pass

    def connect_to_file_share(self):
        """ Connect to file share with a con str, could be KEY or SAS also """
        # Types of credentials
        # https://docs.microsoft.com/en-us/azure/storage/common/authorize-data-access
        if self.file_exist:
            try:
                connection_string = self.connection_string
                service = ShareServiceClient.from_connection_string(
                    conn_str=connection_string)
                self.connection_status = True
            except AttributeError as atter_error:
                print(atter_error)
        else:
            pass

    def fs_list_directory(self, dir_path="testdir"):
        """ Listing contents of a directory """
        if self.connection_status:
            try:
                parent_dir = ShareDirectoryClient.from_connection_string(
                    conn_str=self.connection_string, share_name=self.fs_share, directory_path=dir_path)
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
            except Exception as exe_error:
                print(exe_error)
        else:
            pass

    def fs_upload_file(self, dir_path="testdir"):
        """ Upload a file to dir """
        if self.connection_status:
            # Uploading a file
            file_client = ShareFileClient.from_connection_string(
                conn_str=self.connection_string, share_name="testit3fs", file_path="testdir/az_local_file.txt")
            try:
                with open("az_local_file.txt", "rb") as source_file:
                    rv = file_client.upload_file(source_file)
                    print(rv)
            except FileNotFoundError as file_error:
                print(file_error)
        else:
            pass


def main():
    worker = FilShareUtilityWorker()
    worker.connect_to_file_share()
    worker.fs_list_directory()
    # worker.fs_upload_file()


if __name__ == "__main__":
    main()
    # Optional Configuration
    # https://docs.microsoft.com/en-us/python/api/overview/azure/storage-file-share-readme?view=azure-python
