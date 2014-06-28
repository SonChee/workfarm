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
  validates :due_date,  presence: true, :if => :validate_due_date?

  scope :order_by_created_at, ->{order("created_at DESC")}
  scope :important_find_by_user_id, ->user_id{where(assignee_id: user_id, kind: "Important")}
  scope :important_open_find_by_user_id, ->user_id{where(assignee_id: user_id, kind: "Important", status: ["Open","In process"])}
  scope :in_process_find_by_user_id, ->user_id{where(assignee_id: user_id, status: "In process")}
  scope :all_task_open_find_by_user_id, ->user_id{where(assignee_id: user_id, status: "Open").where.not( kind: "Important")}

  def validate_due_date?
     self.farm_id.present?
  end
  def task_finish?
    self.status == "Resolved" || self.status == "Closed"
  end
  def save_tasks task_params, assignee_ids
    assignee_ids.each do |assignee_id|
      task = Task.new
      task.attributes =  task_params
      task.assignee_id = assignee_id
      task.save
    end
  end
  class << self
    def list_kinds user_type
      list_kinds = ["Important","Normal"]
    end

    def list_status 
      list_kinds = ["Open","In process","Resolved","Closed"]
    end
    def list_assignee_status 
      list_kinds = ["Open","In process","Resolved"]
    end
  end
end
