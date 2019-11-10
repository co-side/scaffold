# ApplicationControllerクラスを継承して、Entryモデルに関するリクエストを処理するコントローラを作成
# MVCにおけるCに相当する
# 基本的にコントローラの名前は複数形を使う
class EntriesController < ApplicationController
  # コントローラー内のアクションの実行前に実行するメソッドを宣言している
  # set_entryメソッドをshow, edit, update, destroyアクションの前に実行する
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :set_blog

  # GET /entries
  # GET /entries.json
  # indexアクションはテーブルに登録されているデータの一覧表示と、CRUDの起点としての役割を持つ
  def index
    # Entriesテーブルのすべてのレコードを取得してインスタンス変数@entriesに代入
    # コントローラーのアクションで作成したインスタンス変数はview側でも呼び出すことが可能
    # @entriesという変数名は複数のレコードを持っていることを示すため複数形になっている
    @entries = Entry.all
  end

  # GET /entries/1
  # GET /entries/1.json
  # CRUDのReadを担うアクション
  # URLパラメータのIDから該当する該当するエントリーを取得し、画面に表示する
  # 取得処理はset_entryで行うためメソッドは空になっている
  def show
    @comment = Comment.new()
  end

  # GET /entries/new
  # CRUDのCreateを実行するためのデータをユーザーに入力してもらう画面を提供するアクション
  def new
    # Entryモデルのオブジェクトを生成
    # モデルはデータベースとやり取りを行うクラス
    @entry = @blog.entries.build
  end

  # GET /entries/1/edit
  # Updateを実行するためのデータをユーザーに入力してもらう画面を提供するアクション
  # Update対象のオブジェクトを取得する処理はset_entryで行うためメソッドは空になっている
  def edit
  end

  # POST /entries
  # POST /entries.json
  # Createを実行するアクション
  def create
    # ユーザーが入力した情報を引数としてEntryモデルのオブジェクトを生成
    # このときentry_paramsを指定することで不正なパラメータの入力を防いでいる
    @entry = @blog.entries.build(entry_params)

    # ユーザーのリクエストに対して、このフォーマットのリクエストに対してはこういうレスポンスをする、と明示的に示す処理
    respond_to do |format|
      # saveメソッドでユーザーが入力した情報をテーブルに保存
      # saveメソッドは返り値として真偽値を返すためそれを用いて処理を分岐させる
      if @entry.save
        # html形式のリクエストに対してのレスポンス
        # redirect_toで処理が完了したあとにリダイレクトする画面を指定。ここでは生成したEntryのshow画面を指定している
        # redirect_to @entryは redirect_to entry_url(@entry.id)と等価。Railsが気を利かせてかなり省略して書けるようになっている
        # entry_urlはヘルパーメソッドで、引数にモデルオブジェクトを渡すとそのオブジェクトのshow画面の絶対パスを生成する
        # notice 'Entry was successfully created.'でリダイレクト後に画面に表示するメッセージを宣言している
        # noticeはflashメッセージでリダイレクト時に一度だけ表示されるメッセージ
        format.html { redirect_to [@blog, @entry], notice: 'Entry was successfully created.' }
        # json形式のリクエストに対してのレスポンス
        # renderメソッドで出力内容を指定している。
        # render :showでshowアクションのviewを出力するよう指定している。json形式であるためshow.jsonビューが出力される
        # status: :createdでレスポンスコード201を返すよう指定している
        # location: @entryでHTTPのLocationヘッダーを設定している。Locationヘッダーはリダイレクト先のURLを指定
        # @entryはでentry_url(@entry.id)の省略形
        format.json { render :show, status: :created, location: [@blog, @entry] }
      else
        # html形式のリクエストに対してのレスポンス
        # レコードの作成に失敗した場合はnewアクションのviewを再度表示
        format.html { render :new }
        # json形式のリクエストに対してのレスポンス
        # @entry.errorsにはレコードの作成に失敗した際のエラー内容がハッシュ形式で格納されており、それをjson形式で表示させる
        # status: :unprocessable_entityでレスポンスコード422を返すよう指定している
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  # EntryモデルのUpdateを実行するアクション
  def update
    respond_to do |format|
      # updateメソッドでレコードのアップデートを実行
      # 引数としてユーザーが入力した情報を指定している（entry_paramsで不正な入力を防止）
      # 返り値は真偽値なので、それを用いて処理を分岐している
      if @entry.update(entry_params)
        # 成功したときはshowへリダイレクトする
        format.html { redirect_to [@blog, @entry], notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: [@blog, @entry] }
      else
        # 失敗したときはeditを再度表示する
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  # レコードの削除（Destroy）を実行するアクション
  def destroy
    # destroyメソッドで削除を実行
    # 返り値は真偽値だが、scaffoldでは削除の成功・失敗は特にチェックせず、成功した場合の処理のみ書かれている
    @entry.destroy
    respond_to do |format|
      # html形式のリクエストの場合、index画面へリダイレクトする。
      format.html { redirect_to @blog, notice: 'Entry was successfully destroyed.' }
      # json形式のリクエストの場合、本文のないレスポンスを送信している
      # headメソッドを使用することでヘッダだけで本文のないレスポンスを送信可能
      # no_contentはステータスコード204に相当する
      format.json { head :no_content }
    end
  end

  # privateメソッド
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      # Entriesテーブルの検索処理
      # URLパラメータのidに入っている値と同じ値のidを持つレコードを取得して、インスタンス変数@entryに代入
      set_blog
      @entry = @blog.entries.find(params[:id])
    end

    def set_blog
      @blog = Blog.find(params[:blog_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      # POSTで受け取る値を制限して不正なパラメータの入力を防ぐ仕組み
      # requireでPOSTで受け取る値のキーを:entryに設定
      # permitで許容するカラムを:title, :bodyに設定
      params.require(:entry).permit(:title, :body)
    end
end
