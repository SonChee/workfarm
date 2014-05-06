class Task < ActiveRecord::Base
	CREATE_COLUMNS_FOR_ADMINS = [:name, :kind, :short_description, :description, 
    :taskmaster_id, :assignee_id, :process, :status, :spent_time, :estimated_time, :start_date, 
    :due_date, :farm_id, :project_id, :target_version]
  CREATE_COLUMNS_FOR_USERS = [:name, :kind, :short_description, :description, 
    :taskmaster_id, :assignee_id, :process, :status, :spent_time, :estimated_time, :start_date, 
    :due_date, :farm_id, :project_id, :target_version]
  belongs_to :master, class_name: "User", foreign_key: :taskmaster_id
  belongs_to :assignee, class_name: "User", foreign_key: :assignee_id
  belongs_to :farm
  
  validates :name,  presence: true
  validates :kind,  presence: true
  validates :status,  presence: true
  validates :taskmaster_id,  presence: true
  validates :assignee_id,  presence: true
  validates :short_description,  presence: true
  validates :description,  presence: true
  validates :estimated_time,  presence: true

  scope :important_find_by_user_id, ->user_id{where(assignee_id: user_id, kind: "Important")}
  scope :in_process_find_by_user_id, ->user_id{where(assignee_id: user_id, status: "In process")}
  scope :all_task_find_by_user_id, ->user_id{where(assignee_id: user_id, status: "Open").where.not( kind: "Important")}
  class << self

    def list_kinds user_type
      if user_type == "Admin"
        list_kinds = ["Important","Normal","Self"]
      elsif user_type == "Member"
        list_kinds = ["Self"]
      else
        list_kinds = ["Self"]
      end
        
    end

    def list_status 
      list_kinds = ["Open","In process","Resolved","Closed"]
    end
  end
end
