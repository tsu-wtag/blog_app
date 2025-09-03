class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  # Everyone can see posts
  def index?; true; end
  def show?; true; end

  # Only logged-in users can create
  def create?; user.present?; end
  def new?; create?; end

  # Only author can edit/update/delete
  def edit?; user.present? && post.user == user; end
  def update?; edit?; end
  def destroy?; edit?; end

  # Scope
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
