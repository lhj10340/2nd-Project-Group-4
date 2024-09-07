package kr.tf.spring.pagination;

public class PageMaker {
    private int currentPage;
    private int totalPages;
    private int startPage;
    private int endPage;

    public PageMaker(int currentPage, int totalCount) {
        this.currentPage = currentPage;
        this.totalPages = (int) Math.ceil(totalCount / 10.0);
        this.startPage = Math.max(1, currentPage - 2);
        this.endPage = Math.min(totalPages, currentPage + 2);
    }

    // Getter 및 Setter
    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }
}
