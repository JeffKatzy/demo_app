class AddAttachmentSoundfileToQuestions < ActiveRecord::Migration
  def self.up
    change_table :questions do |t|
      t.has_attached_file :soundfile
    end
  end

  def self.down
    drop_attached_file :questions, :soundfile
  end
end
