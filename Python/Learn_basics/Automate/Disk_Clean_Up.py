import time
import delete_files


DAYS = 5    # Сколько дней файл может жить, все что старше - удалить
FOLDERS = ["C:/Users/Fiery/OneDrive/Документы/HUY"]

TOTAL_DELETED_SIZE = 0      # Total deleted size of all files
TOTAL_DELETED_FILES = 0     # Total deleted files
TOTAL_DELETED_DIRS = 0      # Total deleted empty folders

now_time = time.time()      # Get current time in SECONDS
age_time = now_time - (60 * 60 * 24 * DAYS)     # Time of file's life



start_time = time.asctime()

for folder in FOLDERS:
    delete_files.delete_old_files(folder, TOTAL_DELETED_FILES, TOTAL_DELETED_SIZE, age_time)    # Delete function of old files
    delete_files.delete_empty_dir(folder, TOTAL_DELETED_DIRS)    # Delete function of empty folders



finish_time = time.asctime()


print(f"START TIME: {str(start_time)}")
print(f"Total deleted size: {str(TOTAL_DELETED_SIZE / 1024 / 1024)} MB")
print(f"Total deleted files: {str(TOTAL_DELETED_FILES)}")
print(f"Total deleted folders: {str(TOTAL_DELETED_DIRS)}")
print(f"Finish time: {str(finish_time)}")

