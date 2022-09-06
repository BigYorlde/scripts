import requests

response = requests.get("https://github.com/BigYorlde/python-scripts.git")
my_projects = response.json()

for project in my_projects:
    print(f"Project name: {project['name']} \nProject Url: {project['web_url']}")

