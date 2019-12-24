class Lives::CreateForm
  include ActiveModel::Model
  attr_accessor :name, :des

  validates :name, presence: true

  def initialize(params)
    @name = params[:name]
    @des = params[:des]
  end

  def create
    if valid?
      lives_service = LivesService.new()
      lives_service.create(name, des)
    else
      [false, errors.messages, 400]
    end
  end
end