# -*- encoding : utf-8 -*-

describe RegApi2::Folder do

  include RegApi2

  EXAMPLE_FOLDER_DATA = { "name" => "test_folder_name", "id" => "-1" }.freeze

  describe :nop do
    it "should raise nothing" do
      expect { folder.nop }.not_to raise_error
    end
    
    it "should return default folder if no ops set" do
      expect(folder.nop).to eq(EXAMPLE_FOLDER_DATA)
    end

    it "should return folder data if folder_id specified" do
      expect(folder.nop(folder_id: 12345)).to eq(EXAMPLE_FOLDER_DATA)
    end
    
    it "should return folder data if test_folder_name specified" do
      expect(folder.nop(folder_name: "test_folder_name")).to eq(EXAMPLE_FOLDER_DATA)
    end  
  end

  describe :create do
    it "should create a folder" do
      expect(folder.create(folder_name: 'test_folder_name')).to be_nil
    end
  end

  describe :remove do
    it "should remove a folder by id" do
      expect(folder.remove(folder_id: 123456)).to be_nil
    end

    it "should remove a folder by name" do
      expect(folder.remove(folder_name: 'test_folder_name')).to be_nil
    end
  end

  describe :rename do
    it "should rename a folder by id" do
      expect(folder.rename(folder_id: 123456, new_folder_name: 'new_test_folder_name')).to have_key(:folder_content)
    end

    it "should rename a folder by name" do
      expect(folder.rename(folder_name: 'test_folder_name', new_folder_name: 'new_test_folder_name')).to have_key(:folder_content)
    end
  end
end
