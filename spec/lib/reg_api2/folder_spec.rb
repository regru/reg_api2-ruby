# -*- encoding : utf-8 -*-

describe RegApi2::Folder do
  describe :nop do
    it "should raise nothing" do
      lambda { RegApi2.folder.nop }.should_not raise_error
    end
    
    it "should return default folder if no ops set" do
      RegApi2.folder.nop.should == { "name" => "test_folder_name", "id" => "-1" }
    end

    it "should return folder data if folder_id specified" do
      RegApi2.folder.nop(folder_id: 12345).should == { "name" => "test_folder_name", "id" => "-1" }
    end
    
    it "should return folder data if test_folder_name specified" do
      RegApi2.folder.nop(folder_name: "test_folder_name").should == { "name" => "test_folder_name", "id" => "-1" }
    end  
  end

end
