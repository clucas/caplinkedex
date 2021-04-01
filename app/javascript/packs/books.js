function () {
    return $("#query").autocomplete({
        source: "/books/autocomplete",
        minLength: 2
    });
}