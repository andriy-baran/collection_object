RSpec.describe CollectionObject do
  it "has a version number" do
    expect(CollectionObject::VERSION).not_to be nil
  end

  it 'makes object behave as collection' do
    klass = Class.new(Object)
    collection_object = klass.extend(CollectionObject[:members]).new
    expect(collection_object.members).to eq([])
    co_methods = collection_object.public_methods - Object.new.public_methods - [:members]
    array_methods = [].public_methods - Object.new.public_methods
    expect(co_methods.sort).to eq(array_methods.sort)
  end
end
