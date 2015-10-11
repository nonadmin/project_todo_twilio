class TodosController < ApplicationController

  def home
    
  end


  def index
    @todo   = Todo.new
    @todos  = Todo.order(:completion)
  end


  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      flash[:success] = "New Todo Created"
      flash[:id] = @todo.id
      redirect_to todos_path
    else
      flash.now[:danger] = "Whoops, something went wrong."
      @todos  = Todo.order(:completion)
      render :index
    end
  end


  def edit
    @todo = Todo.find(params[:id])
    @todos  = Todo.order(:completion)
    render :index
  end


  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
      flash[:info] = "Todo Updated"
      flash[:id] = @todo.id
      redirect_to todos_path
    else
      flash.now[:danger] = "Whoops, something went wrong."
      @todos  = Todo.order(:completion)
      render :index
    end
  end


  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    flash[:warning] = "Todo Deleted."
    redirect_to todos_path
  end


  private


  def todo_params
    params.require(:todo).permit(:description, :completion)
  end

end