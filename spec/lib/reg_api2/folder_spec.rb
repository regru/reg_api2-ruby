# -*- encoding : utf-8 -*-

describe RegApi2::Folder do

  include RegApi2

  EXAMPLE_FOLDER_DATA = { "name" => "test_folder_name", "id" => "-1" }.freeze

  describe :nop do
    it "should raise nothing" do
      lambda { folder.nop }.should_not raise_error
    end
    
    it "should return default folder if no ops set" do
      folder.nop.should == EXAMPLE_FOLDER_DATA
    end

    it "should return folder data if folder_id specified" do
      folder.nop(folder_id: 12345).should == EXAMPLE_FOLDER_DATA
    end
    
    it "should return folder data if test_folder_name specified" do
      folder.nop(folder_name: "test_folder_name").should == EXAMPLE_FOLDER_DATA
    end  
  end

  describe :create do
    it "should create a folder" do
      folder.create(folder_name: 'test_folder_name').should be_nil
    end
  end

  describe :remove do
    it "should remove a folder by id" do
      folder.remove(folder_id: 123456).should be_nil
    end

    it "should remove a folder by name" do
      folder.remove(folder_name: 'test_folder_name').should be_nil
    end
  end
end
