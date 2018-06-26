class MembersController < ApplicationController
  def index
    @member = Member.find_by(name: params[:name])
    @team = Team.find(@member.team_id)
    @team_score = calc_total_score
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update_game
    @member = Member.find(params[:id])
    @member.update(game_id: params[:game_id], score: 0)
    @team = Team.find(@member.team.id)
    @team_score = calc_total_score
    render :index
  end

  def update_score
    @member = Member.find(params[:id])
    @member.update(score: params[:score])
    @team = Team.find(@member.team.id)
    @team_score = calc_total_score
    render :index
  end

  private

  def calc_total_score
    sql = "select count(id) as num, coalesce(sum(score),0) as total from members where team_id = #{@member.team_id} and game_id = 1;"
    darts_total = ActiveRecord::Base.connection.select_all(sql).to_hash
    if darts_total[0]['num'] == 0 then
      darts_avg = 0
    else
      darts_avg = darts_total[0]['total'] / darts_total[0]['num']
    end

    sql = "select coalesce(sum(score),0) as total from members where team_id = #{@member.team_id} and game_id = 3;"
    billiards_total = ActiveRecord::Base.connection.select_all(sql).to_hash

    sql = "select coalesce(sum(score),0) as total from members where team_id = #{@member.team_id} and game_id = 5;"
    golf_total = ActiveRecord::Base.connection.select_all(sql).to_hash

    @team_score = darts_avg + billiards_total[0]['total'] + golf_total[0]['total']
  end
end
