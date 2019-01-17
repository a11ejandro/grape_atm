require 'spec_helper'

describe 'Withdraw', type: :feature do
  let!(:payload) { Payload.create(nominal: 5, number: 3) }

  it 'displays the banknotes withdrawn' do
    params = { amount: 10 }

    post 'api/v1/atm/withdraw', params
    expect(last_response.status).to eq 200
    p json_response
    expect(json_response).to match_as_json([{ 5 => 2 }])
  end

  it 'displays error when there is not enough money to withdraw' do
    params = { amount: 20 }
    post 'api/v1/atm/withdraw', params
    expect(last_response.status).to eq 400
    expect(json_response).to match_as_json('Not enough money')
  end

  it 'displays error request cannot be fullfilled exactly' do
    params = { amount: 3 }
    post 'api/v1/atm/withdraw', params
    expect(last_response.status).to eq 400
    expect(json_response).to match_as_json('The amount cannot be withdrawn exactly')
  end
end
