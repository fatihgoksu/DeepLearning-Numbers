# DeepLearning-Numbers
Sınıflandırma Katmanı(Classification Layer)
Bu katman tam bağlantılı katmandan sonra gelir. Derin öğrenme mimarilerinin bu
katmanında sınıflandırma işlemi yapılmaktadır. Bu katmanın çıkış değeri, sınıflandırması
yapılacak nesne sayısına eşittir. Örneğin 15 farklı nesnenin sınıflandırılması yapılacaksa,
sınıflandırma katmanı çıkış değeri 15 olmalıdır. Tam bağlantılı katmanda çıkış değeri 4096
olarak seçilirse, bu çıkış değerine göre sınıflandırma katmanı için 4096x15 ağırlık matrisi
elde edilir. Bu katmanda farklı sınıflandırıcılar kullanılmaktadır. Çoğunlukla başarısından
dolayı softmax sınıflandırıcı tercih edilir. Sınıflandırmada 15 farklı nesne 0-1 aralığında
belli bir değerde çıkış üretir. 1’e yakın sonucu üreten çıkış, ağın tahmin ettiği nesne olduğu
anlaşılır.
2.2.Evrişimsel Sinir Ağının Eğitilmesi
ESA’nın eğitilmesi adımlar halinde aşağıda belirtilmiştir.
Adım 1. Öncelikle bir ESA modeli oluşturulur. Bu modelde konvolüsyon katman sayısı,
havuzlama katman sayısı, tam bağlantılı katman sayısı ve sınıflandırma katmanı belirlenir.
Bu katmanların sıralanması ve adetleri tasarımcıya özgüdür.
Adım 2. Model oluşturulduktan sonra başlangıç değişkenleri tanımlanır. Bu değişkenler
temel olarak filtre boyutları, filtre sayısı ve adım kayma miktarı olarak sıralanabilir. Ayrıca
her bir filtre için 0-1 aralığında gelişigüzel değerler atanır.
Adım 3. Oluşturulan model giriş verisi olarak eğitim setinden bir görüntü verilir. Bu
görüntü ağdaki katmanlardan geçirilerek bir sonuç değeri elde edilir. Bu aşamaya ileri
besleme denir. İleri beslemede her katmanda her bir filtrenin ağırlıkları ile görüntüdeki
piksel değerleri çarpılıp bunların toplamı alınarak bir sonraki katmana aktarılır. Şekil 12’de
örnek olarak verilen ESA modelinde 5 farklı nesnenin sınıflandırılması yapılmaktadır. Ağa
Elma görüntüsü verildiğinde, [Armut, Muz, Elma, Limon, Nar] için tahmin ettiği değerler
[0.35, 0.05, 0.30, 0.10, 0.20] olduğu görülmektedir.
Adım 4. Eşitlik 6’ya göre, ağın üretmiş olduğu sonuçlar ile hedef sonuçların farkı alınarak
toplam hata değeri hesaplanır.
Adım 5. Elde edilen hata değerinin ağdaki bütün ağırlıklara dağıtılması gerekmektedir. Bu
işlem için Geriye Yayılım Algoritması(GYA) kullanılır. GYA’da her bir ağırlığın toplam
hataya olan etkisinin hesaplanması için Stokastik Gradyan İniş(SGİ) optimizasyon
algoritması kullanılır. Buradaki ağırlıkların güncellenmesiyle ağın çıkışındaki toplam hata değeri düşürülmeye çalışılır. Dolayısıyla sınıflandırma başarısının arttırılması
amaçlanmaktadır. Bu adımdan sonra ağa tekrar Elmaya ait başka bir görüntü verildiğinde
bu sefer [Armut, Muz, Elma, Limon, Nar] için tahmin edilen değerler [0.1, 0.01, 0.8, 0.07,
0.02] olarak elde edilir. Dikkat edilirse ağırlıklar ilk görüntüden sonra güncellendiğinden
Elma için yapılan tahmin 1’e yaklaşmıştır.
ESA’larda ağırlıkların güncellenmesi için farklı gradyan tabanlı optimizasyon algoritmaları
kullanılmaktadır. Bu algoritmaların birbirlerine göre avantaj ve dezavantajları(Ruder 2016)
çalışmada detaylı bir şekilde anlatılmıştır. GYA’da her bir ağırlığın değeri Gradyan iniş
yöntemine göre hesaplanırken kısmi türev kullanılır ve Zincir kuralına göre yapılır. Şekil
13’te verilen örnek bir ağ üzerinde ağırlıkların güncellenmesi için öncelikle z’nin y1’e göre
ve y1’in x’e göre türevi ile z’nin y2’ye göre ve y2’in x’e göre türevi alınarak ikisinin
toplamı alınır. Bu iki değerin toplamı, z’nin x’e göre kısmi türevini verir.
Adım 6. Eğitim kümesindeki bütün görüntüler için Adım 3-5 tekrar edilir.
