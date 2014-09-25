# encoding: utf-8

class User < ActiveRecord::Base
  attr_accessible :food, :name

  validates_presence_of :name, :message => '入力して下さい'
  validates_presence_of :food, :message => '入力して下さい'
  validates_length_of :food, maximum: 30, message: '30文字以内で入力して下さい'
end
