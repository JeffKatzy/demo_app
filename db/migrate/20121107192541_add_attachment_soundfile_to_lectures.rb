class AddAttachmentSoundfileToLectures < ActiveRecord::Migration
  def self.up
    change_table :lectures do |t|
      t.has_attached_file :soundfile
    end
  end

  def self.down
    drop_attached_file :lectures, :soundfile
  end
end
