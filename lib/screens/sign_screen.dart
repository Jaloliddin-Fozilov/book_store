import 'package:flutter/material.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Image.network(
                  'https://download.flaticon.com/download/icon/149071?icon_id=149071&author=159&team=159&keyword=User&pack=148705&style=Flat&style_id=28&format=png&color=%23000000&colored=2&size=512%2C256%2C128%2C64%2C32%2C24%2C16&selection=1&premium=&type=standard&token=03AGdBq24Teo853wgk-qGyH787H5TRqx3A5lnC0zf2bLUoeqjIjl4R8oRuZ9imdEiaqRGlcqPlP1m2SOzijEQKPQs1TjqGPQC4rUXBNPpjn7eddmgcSd7tZkoE3gC4F9SvLfAkkG-3OTnFxqQfFbKtkEuyrAARWieRMyeFFmxSI56mrlZ1AECS_GSgVuJB_nIeOtpfzRRrOh0N0dkzathbr59SfcU6FgHvVIlaEkuT8kSz3ddU3arHvUB2WCcg7AbcAmUfNcakXYT6s4HOXQzt_MdvwcU0u_4q8ntAyied8yPLooWUZPu3pZCCyiSU9dsfOtoKt2esX8FlwbY4RShCinJD7PisL0OnQaz6-yCeXwMcjTVfRKLo6bogQDd0ZHUW8fRGX9sEABx3EIKG7ZoHLmF8qNXe72Vw2PS-KXhbyBu1wiY7SNOxPzjYAIi_NqQB3VkzO7HR0XJMHhv253PCTtJ_Yy3oPJyUIGR6C19-Zbxzzp6R531XOn1eauGsfpnBt0VF3gf18vG2-f45qKHzG56kzpRYNDZkowJC9GL8vqgmxXy5wphomWcUIGF3BfALhUSJqLr_5RNNoQ_z4-xgpanjbHD8p8OzrR42YypYRbQe6oL1inPELH0aZ_rrPJl85mL0sr-_-doPxtyhZzM3xFQoSPT9IXPGsNdnvG6_MoSNwl3b9V63mDdNncj3mO5sfQaH43gX2iOf3uISkfjHlOPbyFEZynxVkWodteOn9IXjYTU4nza-0um114KodBX6rjDxAlErkuj80NJhEGypZkzr0C-2EAPCJzKZs6xBDQGhsrt2Pbr68jJFuDgrfbMhWOonIdHCwhjJbRh5uqP7ejxwzP7_1UuM8gfNlPVcsw_6lJjPLYY9o1dy2aG0bt80K1eBIS5Xy3rQsHCx6e4TaejaTkk-vZELKiPbJ0o26CXETvyAZOM0ofDltsHgsZSnDNYHS0fcfMs3VTOqestHK-jRiE-cn_9S45IWMfdoVPYWCRg5gwt0QRgQKDaxW6iPViLCuL-an4bhw4TUKaW-bnI9GLJnLFps3UPrxIzI9JQKOZfRnKkroIHVVieXmyfO-VBnfutASlwv76PHbL56zuWOjIgNRnUReyYP1PsAtc9qAIqZfeLSLVGIXrT5XZNrQZ9lpBt3PlSjJ4aNssp6JGSLhElYHTu1mLWGli5Q9ERNV-DTbaWbCz3zSMr9lbxfTGDZQkdKzZFM&search=profile&_gl=1*go3hug*test_ga*NTcwNzMzNTUwLjE2NTM0OTMwNjA.*test_ga_523JXC6VL7*MTY1MzQ5MzA2MC4xLjEuMTY1MzQ5MzA3OS40MQ..*fp_ga*NTcwNzMzNTUwLjE2NTM0OTMwNjA.*fp_ga_1ZY8468CQB*MTY1MzQ5MzA2MC4xLjEuMTY1MzQ5MzA3OS40MQ..',
                  fit: BoxFit.cover,
                  width: 75,
                  height: 75,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
