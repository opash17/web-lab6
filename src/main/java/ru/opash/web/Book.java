package ru.opash.web;

/**
 * Запись учебного каталога книг.
 */
public final class Book {
    private final String author;
    private final String title;
    private final boolean read;

    /**
     * Создаёт запись каталога.
     *
     * @param author автор книги
     * @param title название книги
     * @param read признак прочтения
     */
    public Book(String author, String title, boolean read) {
        this.author = author;
        this.title = title;
        this.read = read;
    }

    /**
     * Возвращает автора книги.
     *
     * @return автор книги
     */
    public String getAuthor() { return author; }

    /**
     * Возвращает название книги.
     *
     * @return название книги
     */
    public String getTitle() { return title; }

    /**
     * Определяет, прочитана ли книга.
     *
     * @return {@code true}, если книга прочитана
     */
    public boolean isRead() { return read; }

    /**
     * Экранирует символы, которые имеют специальное значение в HTML.
     *
     * @param value исходная строка
     * @return строка, безопасная для вставки в HTML
     */
    public static String escapeHtml(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}
