"""Проверка аутентификации и работы защищённого JSP-приложения."""
from base64 import b64encode
from urllib.error import HTTPError, URLError
from urllib.parse import urlencode
from urllib.request import Request, urlopen
import ssl

HTTP_BASE = "http://localhost:8081/lab6-webapp"
HTTPS_BASE = "https://localhost:8443/lab6-webapp"
AUTH = b64encode(b"student:web2026").decode("ascii")


def request(url, data=None, authenticated=False, insecure_tls=False):
    headers = {"Authorization": "Basic " + AUTH} if authenticated else {}
    payload = urlencode(data).encode("utf-8") if data else None
    context = ssl._create_unverified_context() if insecure_tls else None
    return urlopen(Request(url, data=payload, headers=headers), context=context, timeout=10)


def main():
    with request(HTTP_BASE + "/") as response:
        assert response.status == 200 and "Защищённый каталог книг" in response.read().decode("utf-8")
    try:
        request(HTTP_BASE + "/BookList.jsp", {"name": "Опаш А. Б."})
        raise AssertionError("Ожидался ответ 401 без учётных данных")
    except HTTPError as error:
        assert error.code == 401
    with request(HTTP_BASE + "/BookList.jsp", {"name": "Опаш А. Б.", "filter": "unread"}, True) as response:
        page = response.read().decode("utf-8")
        assert response.status == 200 and "Доступ разрешён: <strong>student</strong>" in page and "В списке: <strong>3</strong>" in page
    with request(HTTPS_BASE + "/BookList.jsp", {"name": "Опаш А. Б."}, True, True) as response:
        assert response.status == 200 and "BASIC" in response.read().decode("utf-8")
    print("Проверка пройдена: HTTP 401, BASIC-аутентификация и HTTPS работают.")


if __name__ == "__main__":
    try:
        main()
    except URLError as error:
        raise SystemExit("Tomcat недоступен: " + str(error.reason))
