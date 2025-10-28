require 'json'

class InventoryDB
    FILE_PATH = "inventory_data.json"
    
    attr_accessor :items, :quantities
    def initialize()
        if File.exist?(FILE_PATH)
            data = JSON.parse(File.read(FILE_PATH))
            @items = data["items"].map { |i| i.strip.upcase }
            @quantities = data["quantities"].map(&:to_i)
        else
            @items = []
            @quantities = []
        end
    end
        
    def save
        data = {"items" => @items, "quantities" => @quantities }
        File.write(FILE_PATH, JSON.pretty_generate(data))
    end
    
    def add(item,quantity)
        normalized_item = item.strip.upcase
        if @items.include?(normalized_item)
            index = @items.find_index(normalized_item)
            @quantities[index] += quantity.to_i
        else
            @items << normalized_item
            @quantities << quantity.to_i
        end
        save
    end
    
    def batch(items,quantities)
        return if items.nil? || quantities.nil?
        items.each_with_index do |item,i|
            next if item.nil? || item.strip.empty?
            normalized_item = item.strip.upcase
            quantity = quantities[i].to_i

            if @items.include?(normalized_item)
                index = @items.find_index(normalized_item)
                @quantities[index] += quantity
            else
                @items << normalized_item
                @quantities << quantity
            end
        end
        save
    end
    
    def edit(item,new_quantity)
        normalized_item = item.strip.upcase
        index = @items.find_index(normalized_item)
        if index
            @quantities[index] = new_quantity.to_i
            save
        end
    end
    
    def delete(item)
        normalized_item = item.strip.upcase
        index = @items.find_index(normalized_item)
        if index
            @items.delete_at(index)
            @quantities.delete_at(index)
            save
        end
    end
    
    def all()
        @items.zip(@quantities)
    end
    
    def find(item)
      index = @items.find_index(item)
      return nil unless index
      { name: @items[index], quantity: @quantities[index] }
    end
    
end
