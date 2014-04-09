class TopicPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    user.present? && user.role?(:admin)
  end

  def update?
    create?
  end
#Only show topics that are public. If they are not public,
#ie. private, then show the private topic if a user 
#is present/signed in. This ensures that only members can view
#private topoics since only members can sign in.
  def show?
    record.public? || user.present?
  end
  
end