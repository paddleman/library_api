defmodule LibraryApi.Library do
  
  import Ecto.Query

  alias LibraryApi.Repo
  alias LibraryApi.Library.Author
  alias LibraryApi.Library.Book
  alias LibraryApi.Library.Review
  
#  ###### Authors  #######
  def search_authors(search_term) do
    search_term = String.downcase(search_term)

    Author
    |> where([a], like(fragment("lower(?)", a.first), ^"%#{search_term}%"))
    |> or_where([a], like(fragment("lower(?)", a.last), ^"%#{search_term}%"))
    |> Repo.all()
  end

  def list_authors, do: Repo.all(Author)

  def get_author_for_book!(book_id) do
    book = get_book!(book_id)
     
    book = Repo.preload(book, :author)
    
    book.author
  end

  def get_author!(id), do: Repo.get(Author, id)

  def create_author (attrs \\ %{}) do
    %Author{}
    |>Author.changeset(attrs)
    |>Repo.insert
  end

  def update_author(%Author{} = model, attrs \\ %{}) do
    model
    |>Author.changeset(attrs)
    |>Repo.update
  end

  def delete_author(%Author{} = model), do: Repo.delete(model)

# ##### Books ######
def search_books(search_term) do
  search_term = String.downcase(search_term)

  Book
  |> where([b], like(fragment("lower(?)", b.title), ^"%#{search_term}%"))
  |> or_where([b], like(fragment("lower(?)", b.isbn), ^"%#{search_term}%"))
  |> Repo.all()
end

def list_books, do: Repo.all(Book)

def list_books_for_author(author_id) do
  Book
  |> where([b], b.author_id == ^author_id)
  |> Repo.all()
end


def get_book!(id), do: Repo.get(Book, id)

def get_book_for_review!(review_id) do
  review = get_review!(review_id)

  review = Repo.preload(review, :book)
  
  review.book
end

def create_book (attrs \\ %{}) do
  %Book{}
  |>Book.changeset(attrs)
  |>Repo.insert
end

def update_book(%Book{} = model, attrs \\ %{}) do
  model
  |>Book.changeset(attrs)
  |>Repo.update
end

def delete_book(%Book{} = model), do: Repo.delete(model)


 def list_reviews do
    Repo.all(Review)
  end

  def list_reviews_for_book(book_id) do
    Review
    |> where([r], r.book_id == ^book_id)
    |> Repo.all()
  end



  def get_review!(id), do: Repo.get!(Review, id)

  def create_review(attrs \\ %{}) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end

  def update_review(%Review{} = review, attrs) do
    review
    |> Review.changeset(attrs)
    |> Repo.update()
  end

  def delete_review(%Review{} = review) do
    Repo.delete(review)
  end

end
