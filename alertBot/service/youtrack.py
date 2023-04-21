from .bot import bot
from .database import get_user_by_email


def assignee_alert(data: dict) -> None | int:
    try:
        email = data['email']
        description = data['description']
        summary = data['summary']
        issue_link = data['link']
    except KeyError:
        return None

    assignee = get_user_by_email(email)

    if assignee is not None:
        bot.send_message(assignee.telegram_id,
                         "На вас назначена новая задача!\n\n"
                         f"Название: <a href='{issue_link}'>{summary}</a>\n\n"
                         f"Описание: {description}")
        return 0

    return None


def notify(data: dict) -> None | int:
    try:
        email = data['email']
        summary = data['summary']
        issue_link = data['link']
        state = data['state']
    except KeyError:
        return None

    user = get_user_by_email(email)

    if user is not None:
        bot.send_message(user.telegram_id,
                         f"У задачи <a href='{issue_link}'>{summary}</a> "
                         f"новый статус: <b>{state}</b>")
        return 0

    return None
