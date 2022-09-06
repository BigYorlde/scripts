import user
import post

app_user_one = user.User("pp@pp.ru", "Ivan Pavlov", "pwd1", "DevOps Engineer in the future")
app_user_one.get_user_info()

app_user_one.change_job_title("DevOps huesos")
app_user_one.get_user_info()

app_user_two = user.User("huy@huy.com", "Chlen", "Jigalo", "Cocksucker")
app_user_two.get_user_info()

new_post = post.Post("on a secret mission today", app_user_two.name)
new_post.get_post_info()