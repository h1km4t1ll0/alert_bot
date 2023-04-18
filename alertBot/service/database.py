from alertBot.models import *


def check_user_exists(telegram_id: str) -> bool:
    user: [BotUser] = BotUser.objects.filter(telegram_id=telegram_id)

    if len(user) == 0:
        return False

    if len(user) == 1:
        return True


def get_user_by_email(email: str) -> BotUser | None:
    user: [BotUser] = BotUser.objects.filter(email=email)

    if len(user) == 0:
        return None

    if len(user) == 1:
        return user[0]
