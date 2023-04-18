;;--------------------------------
;;# lispメモ
;;## 構文
;; (let ((a 1))) ローカル変数aに1を代入
;; (define a 1) グローバル変数aに1を代入
;; (set! a 1) 定義済み変数aに1を代入
;;## gimp
;; lispとはいえ、使えないものがいっぱいある
;; 参考：https://seesaawiki.jp/w/ryunosinfx/d/Script-fu%A4%CB%A4%C7%A4%AD%A4%EB%A4%B3%A4%C8%A4%C7%A4%AD%A4%CA%A4%A4%A4%B3%A4%C8
;;
;; imageとdrawableという概念がある
;; imageは画像やファイルみたいなイメージ
;; drawableは編集しているデータの集合体のようなイメージ
;; 参考：https://yasuo-ssi.hatenablog.com/entry/2021/02/24/000000
;;
;;--------------------------------


;; iPhone12MaxProのスクショサイズ前提

;; 固定矩形サイズで切り抜く
(define (nyanko-party-thumbnail-crop image)
  (gimp-image-crop image 1340 360 805 168)
  )

;; 固定矩形サイズで切り抜いて、pngで保存する
(define (nyanko-party-thumbnail-crop-save image filename)
  (nyanko-party-thumbnail-crop image)
  ;; pngとしてセーブする(jpg指定のfile-jpeg-saveや、gimp任せのgimp-file-saveがある)
  ;; RUN-NONINTERACTIVE ダイアログなしでセーブされる
  ;; RUN-INTERACTIVE ダイアログありでオプションが選べる
  (file-png-save-defaults
   RUN-NONINTERACTIVE
   image
   (car (gimp-image-get-active-drawable image))
   filename
   filename
   )
  )

;; 一括切り抜き処理
(define (run-all-nyanko-party-thumbinail-crop-save)
  (define (loop-func array)
    (let
	(
	 (filename (car array))
	 )
      (unless (equal? filename "")
      (nyanko-party-thumbnail-crop-save
       (car (gimp-file-load RUN-NONINTERACTIVE filename filename)) ;;gimp-file-loadの返り値がIMAGE型のリストになっている
       (string-append filename "_thumb.png") ;; 出力ファイル名を生成する
       )
      (loop-func (cdr array))
      )
      )
    )
  (loop-func
   ;; listにファイル名を追加し、最後を""で終わらせること
   (list
    ;;"c:/Users/username/Desktop/image.PNG"
    ""
    )
   )
  )

