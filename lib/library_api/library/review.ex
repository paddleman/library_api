defmodule LibraryApi.Library.Review do
  use Ecto.Schema
  import Ecto.Changeset


  schema "reviews" do
    field :body, :string
    field :user, :string
    
    belongs_to :book, LibraryApi.Library.Book

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:user, :body, :book_id])
    |> validate_required([:user, :body, :book_id])
  end
end
