class IntsubnetController < ApplicationController
  def list
    select(:Interface, :subnet, Interface.all.collect {|p| [ p.subnet, p.id ] })
  end
end


