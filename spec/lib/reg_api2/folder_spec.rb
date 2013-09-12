# -*- encoding : utf-8 -*-

describe RegApi2::Folder do
  describe :nop do
    it "should raise nothing" do
      lambda { RegApi2.folder.nop }.should_not raise_error
    end
    
    it "should return default folder if no ops set" do
      RegApi2.folder.nop.should == { "name" => "test_folder_name", "id" => "-1" }
    end

    it "should return bill if specified" do
      RegApi2.folder.nop(folder_id: 12345).should have_key :id
    end

    it "should return bills if specified" do
      RegApi2.folder.nop(folder_name: "test_folder_name").should have_key :name
    end  
  end

end
