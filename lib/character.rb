class Character < ActiveRecord::Base
    has_many :characters_groups
    has_many :groups, through: :characters_groups

    def join_group(group)
        self.groups << group
    end

    def leave_group(group)

    end

    def leave_all_groups
        self.groups.clear
    end

    def died
        self.destroy
    end

end