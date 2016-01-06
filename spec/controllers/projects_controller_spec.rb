require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe 'POST #create' do
    context 'with valid attributes' do

      it 'creates the project' do
        post :create, project: {title: :title}
        expect(Project.count).to eq(1)
      end

      it 'redirects to the "index" action' do
        post :create, project: {title: :title}
        expect(response).to redirect_to action: :index
      end

    end

    context 'with invalid attributes' do

      it 'does not creates the project' do
        post :create, project: {title: ''}
        expect(Project.count).to eq(0)
      end

      it 're-renders the "new" view' do
        post :create, project: {title: ''}
        expect(response).to render_template :new
      end

    end
  end

  describe 'PUT #update/:id' do

    before(:each) do
      @project = Project.create(title: :title)
    end

    context 'with valid attributes' do

      it 'updates the project' do
        put :update, id: @project.id, project: {title: :another_title}
        expect(Project.find(@project.id).title).to eq('another_title')
      end

      it 'redirects to the "index" action' do
        put :create, id: @project.id, project: {title: :another_title}
        expect(response).to redirect_to action: :index
      end

    end

    context 'with invalid attributes' do

      it 'does not updates the project' do
        put :update, id: @project.id, project: {title: ''}
        expect(Project.find(@project.id).title).to eq('title')
      end

      it 're-renders the "edit" view' do
        put :update, id: @project.id, project: {title: ''}
        expect(response).to render_template :edit
      end

    end

    context 'when requested project does not exists' do
      it 'throws ActiveRecord::RecordNotFound' do
        expect { put :update, id: -1 }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end

  describe 'delete #destroy/:id' do
    context 'when requested project exists' do
      let(:project) { Project.create(title: :title) }

      it 'removes project form DB' do
        delete :destroy, id: project.id
        expect(Project.all).not_to include project
        expect { project.reload }.to raise_exception ActiveRecord::RecordNotFound
      end
    end

    context 'when requested project does not exists' do
      it 'throws ActiveRecord::RecordNotFound' do
        expect { delete :destroy, id: -1 }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end

end
