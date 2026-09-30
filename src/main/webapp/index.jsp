<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Защищённый каталог книг</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<main class="card">
    <p class="eyebrow">Лабораторная работа № 6</p>
    <h1>Защищённый каталог книг</h1>
    <p class="intro">После отправки формы браузер запросит имя и пароль. Доступ к каталогу получают пользователи с ролью <code>catalog-user</code>.</p>
    <form action="BookList.jsp" method="post" accept-charset="UTF-8">
        <label for="name">Имя читателя</label>
        <input id="name" name="name" type="text" maxlength="80" placeholder="Например, Опаш А. Б." required>
        <label for="filter">Показать</label>
        <select id="filter" name="filter">
            <option value="all">Все книги</option>
            <option value="unread">Только непрочитанные</option>
            <option value="read">Только прочитанные</option>
        </select>
        <button type="submit">Открыть каталог</button>
    </form>
    <p class="note">Учебная учётная запись: <strong>student</strong>, пароль: <strong>web2026</strong>.</p>
</main>
</body>
</html>
