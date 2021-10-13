require "collection_object/version"

module CollectionObject
  def self.array_methods
    [].public_methods - Object.new.public_methods
  end

  def self.[](members)
    mod = Module.new do
      define_singleton_method(:included) do |receiver|
        receiver.send(:attr_reader, members)
      end

      define_singleton_method(:extended) do |receiver|
        receiver.send(:include, self)
      end

      CollectionObject.array_methods.each do |array_method|
        define_method(array_method) do |*params, &block|
          res = send(members).public_send(array_method, *params, &block)
          res.is_a?(Array) ? self.class.new(*res) : res
        end
      end

      define_method(:initialize) do |*args, &block|
        instance_variable_set(:"@#{members}", args)
      end

      define_method(:query) do |commands|
        collection = self
        commands.each do |method_name, attrs|
          collection = collection.public_send(method_name) do |member|
            member.public_send(*attrs)
          end
        end
        collection
      end
    end
  end
end
