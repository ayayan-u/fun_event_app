class MembersController < ApplicationController
  def index
    @member = Member.find_by(name: params[:name])
    @team = Team.find(@member.team_id)
    @team_score = 'xxx'
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update_game
    @member = Member.find(params[:id])
    @member.update(game_id: params[:game_id])
    @team = Team.find(@member.team.id)
    render :index
  end

  def update_score
    @member = Member.find(params[:id])
    @member.update(score: params[:score])
    @team = Team.find(@member.team.id)
    render :index
  end
end
