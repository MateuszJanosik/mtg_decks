class UserDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    @view_columns ||= {
      username: { source: "User.username", cond: :like },
      email: { source: "User.email", cond: :like },
      roles: { source: "User.roles_mask" },
    }
  end

  def data
    records.map do |record|
      {
        username: record.username,
        email: record.email,
        roles: record.roles.join(', '),
      }
    end
  end

  def get_raw_records
    User.all
  end

end