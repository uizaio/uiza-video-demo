class CreateStructureTables < ActiveRecord::Migration[6.0]
  def change
    table_options = 'ENGINE=InnoDB DEFAULT CHARSET=utf8'

    create_table 'uploads', force: :cascade, options: table_options do |t|
      t.string  'code', limit: 100, default: ''
      t.string  'file_local_path', default: ''
      t.string  'uiza_id', limit: 100, default: ''
      t.string  'thumbnail', default: ''
      t.integer 'status', default: 0
      t.timestamps

      t.index :code
      t.index :uiza_id
    end

    create_table 'lives', force: :cascade, options: table_options do |t|
      t.string  'code', limit: 100, default: ''
      t.string 'name', default: ''
      t.text 'des'
      t.string 'stream_url', default: ''
      t.string 'stream_key', default: ''
      t.string  'uiza_id', limit: 100, default: ''
      t.string  'thumbnail', default: ''
      t.integer 'status', default: 0
      t.timestamps

      t.index :code
      t.index :uiza_id
    end
  end
end
