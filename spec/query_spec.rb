RSpec.describe CollectionObject do
  it 'makes object behave as collection' do
    klass = Class.new(Object)
    collection_object = klass.extend(CollectionObject[:members]).new
    collection_object += [1,2,3,4,5,6,7,8]
    res = collection_object.query({ select: [:<, 4], map: [:*, 2] })
    expect(res.members).to eq([2,4,6])
    expect(collection_object).to eq [1,2,3,4,5,6,7,8]
  end
end