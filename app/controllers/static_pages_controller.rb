class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def contact
  end
  # 对于非资源式路由，我们不需要在action中去指定渲染模版，默认渲染模版就是action名对应模版
  # 我们甚至连controller中的action都可以不写，也能正确渲染模版
end
