class AddAttachmentExplanationfileToQuestions < ActiveRecord::Migration
  def self.up
    change_table :questions do |t|
      t.has_attached_file :explanationfile
    end
  end

  def self.down
    drop_attached_file :questions, :explanationfile
  end
end
