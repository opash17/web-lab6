<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ru.opash.web.Book, java.util.ArrayList, java.util.List, javax.servlet.http.HttpServletResponse" %>
<%!
    private static String selected(String actual, String expected) {
        return expected.equals(actual) ? "selected" : "";
    }
%>
<%
    request.setCharacterEncoding("UTF-8");
    String name = request.getParameter("name");
    if (name == null || name.trim().isEmpty()) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Не задано имя читателя.");
        return;
    }
    name = name.trim();
    String filter = request.getParameter("filter");
    if (!"read".equals(filter) && !"unread".equals(filter)) filter = "all";

    List<Book> catalog = new ArrayList<>();
    catalog.add(new Book("Михаил Булгаков", "Мастер и Маргарита", true));
    catalog.add(new Book("Фёдор Достоевский", "Преступление и наказание", false));
    catalog.add(new Book("Лев Толстой", "Война и мир", false));
    catalog.add(new Book("Антон Чехов", "Рассказы", true));
    catalog.add(new Book("Александр Пушкин", "Капитанская дочка", false));

    List<Book> books = new ArrayList<>();
    for (Book book : catalog) {
        if ("all".equals(filter) || ("read".equals(filter) && book.isRead())
                || ("unread".equals(filter) && !book.isRead())) books.add(book);
    }
    String readerName = Book.escapeHtml(name);
    String userName = Book.escapeHtml(request.getRemoteUser());
%>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Книги читателя</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<main class="card wide">
    <a class="back" href="index.jsp">← К форме</a>
    <p class="eyebrow">Доступ разрешён: <strong><%= userName %></strong></p>
    <h1>Книги читателя <%= readerName %></h1>
    <p class="intro">Используется схема <code><%= request.getAuthType() %></code>; ресурс открыт для роли <code>catalog-user</code>.</p>
    <form class="inline-form" action="BookList.jsp" method="post" accept-charset="UTF-8">
        <input type="hidden" name="name" value="<%= readerName %>">
        <label for="filter">Показать</label>
        <select id="filter" name="filter">
            <option value="all" <%= selected(filter, "all") %>>Все книги</option>
            <option value="unread" <%= selected(filter, "unread") %>>Непрочитанные</option>
            <option value="read" <%= selected(filter, "read") %>>Прочитанные</option>
        </select>
        <button type="submit">Обновить</button>
    </form>
    <table>
        <thead><tr><th>Автор</th><th>Название</th><th>Статус</th></tr></thead>
        <tbody>
        <% for (Book book : books) { %>
            <tr>
                <td><%= Book.escapeHtml(book.getAuthor()) %></td>
                <td><%= Book.escapeHtml(book.getTitle()) %></td>
                <td><span class="status <%= book.isRead() ? "done" : "todo" %>"><%= book.isRead() ? "Прочитана" : "Не прочитана" %></span></td>
            </tr>
        <% } %>
        </tbody>
    </table>
    <p class="note">В списке: <strong><%= books.size() %></strong></p>
</main>
</body>
</html>
