PGDMP  ,                    |           eHotel    16.1    16.1 E    !           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            "           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            #           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            $           1262    24746    eHotel    DATABASE     �   CREATE DATABASE "eHotel" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "eHotel";
                postgres    false            �            1259    24747    amenity    TABLE     s   CREATE TABLE public.amenity (
    amenity_id integer NOT NULL,
    amenity_name character varying(255) NOT NULL
);
    DROP TABLE public.amenity;
       public         heap    postgres    false            �            1259    24750    amenity_amenity_id_seq    SEQUENCE     �   CREATE SEQUENCE public.amenity_amenity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.amenity_amenity_id_seq;
       public          postgres    false    215            %           0    0    amenity_amenity_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.amenity_amenity_id_seq OWNED BY public.amenity.amenity_id;
          public          postgres    false    216            �            1259    24751    archive    TABLE     O   CREATE TABLE public.archive (
    id integer NOT NULL,
    information text
);
    DROP TABLE public.archive;
       public         heap    postgres    false            �            1259    24756    archive_id_seq    SEQUENCE     �   CREATE SEQUENCE public.archive_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.archive_id_seq;
       public          postgres    false    217            &           0    0    archive_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.archive_id_seq OWNED BY public.archive.id;
          public          postgres    false    218            �            1259    24757    booking    TABLE     �   CREATE TABLE public.booking (
    customer_ssn character varying(20) NOT NULL,
    room_number integer NOT NULL,
    hotel_address character varying(255) NOT NULL
);
    DROP TABLE public.booking;
       public         heap    postgres    false            �            1259    24760    chainphonenumber    TABLE     �   CREATE TABLE public.chainphonenumber (
    central_office_address character varying(255) NOT NULL,
    phone_number character varying(20) NOT NULL
);
 $   DROP TABLE public.chainphonenumber;
       public         heap    postgres    false            �            1259    24763    customer    TABLE     �   CREATE TABLE public.customer (
    customer_ssn character varying(20) NOT NULL,
    register_date date,
    customer_full_name character varying(255),
    customer_address character varying(255),
    payment_status character varying(50)
);
    DROP TABLE public.customer;
       public         heap    postgres    false            �            1259    24768    defect    TABLE     �   CREATE TABLE public.defect (
    room_number integer NOT NULL,
    hotel_address character varying(255) NOT NULL,
    defect_description text
);
    DROP TABLE public.defect;
       public         heap    postgres    false            �            1259    24773    employee    TABLE     �   CREATE TABLE public.employee (
    employee_ssn character varying(20) NOT NULL,
    hotel_address character varying(255) NOT NULL,
    employee_full_name character varying(255),
    employee_address character varying(255)
);
    DROP TABLE public.employee;
       public         heap    postgres    false            �            1259    24778    hotel    TABLE     *  CREATE TABLE public.hotel (
    hotel_address character varying(255) NOT NULL,
    central_office_address character varying(255) NOT NULL,
    star_rating integer,
    hotel_email character varying(255),
    CONSTRAINT hotel_star_rating_check CHECK (((star_rating >= 0) AND (star_rating <= 5)))
);
    DROP TABLE public.hotel;
       public         heap    postgres    false            �            1259    24784 
   hotelchain    TABLE     �   CREATE TABLE public.hotelchain (
    central_office_address character varying(255) NOT NULL,
    email_address character varying(255),
    number_of_hotels integer,
    CONSTRAINT hotelchain_number_of_hotels_check CHECK ((number_of_hotels >= 0))
);
    DROP TABLE public.hotelchain;
       public         heap    postgres    false            �            1259    24790    hotelphonenumber    TABLE     �   CREATE TABLE public.hotelphonenumber (
    hotel_address character varying(255) NOT NULL,
    phone_number character varying(20) NOT NULL
);
 $   DROP TABLE public.hotelphonenumber;
       public         heap    postgres    false            �            1259    24793    manages    TABLE     �   CREATE TABLE public.manages (
    employee_ssn character varying(20) NOT NULL,
    hotel_address character varying(255) NOT NULL
);
    DROP TABLE public.manages;
       public         heap    postgres    false            �            1259    24796    renting    TABLE     �   CREATE TABLE public.renting (
    room_number integer NOT NULL,
    hotel_address character varying(255) NOT NULL,
    customer_ssn character varying(20) NOT NULL,
    employee_ssn character varying(20) NOT NULL
);
    DROP TABLE public.renting;
       public         heap    postgres    false            �            1259    24799    room    TABLE     �  CREATE TABLE public.room (
    room_number integer NOT NULL,
    hotel_address character varying(255) NOT NULL,
    capacity integer,
    view character varying(50),
    price numeric(10,2),
    extendability boolean,
    booking_start_date date,
    booking_end_date date,
    room_status character varying(50),
    CONSTRAINT room_capacity_check CHECK ((capacity >= 0)),
    CONSTRAINT room_price_check CHECK ((price >= (0)::numeric))
);
    DROP TABLE public.room;
       public         heap    postgres    false            �            1259    24804    roomamenity    TABLE     �   CREATE TABLE public.roomamenity (
    room_number integer NOT NULL,
    amenity_id integer NOT NULL,
    hotel_address character varying(255) NOT NULL
);
    DROP TABLE public.roomamenity;
       public         heap    postgres    false            O           2604    24807    amenity amenity_id    DEFAULT     x   ALTER TABLE ONLY public.amenity ALTER COLUMN amenity_id SET DEFAULT nextval('public.amenity_amenity_id_seq'::regclass);
 A   ALTER TABLE public.amenity ALTER COLUMN amenity_id DROP DEFAULT;
       public          postgres    false    216    215            P           2604    24808 
   archive id    DEFAULT     h   ALTER TABLE ONLY public.archive ALTER COLUMN id SET DEFAULT nextval('public.archive_id_seq'::regclass);
 9   ALTER TABLE public.archive ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217                      0    24747    amenity 
   TABLE DATA           ;   COPY public.amenity (amenity_id, amenity_name) FROM stdin;
    public          postgres    false    215   kY                 0    24751    archive 
   TABLE DATA           2   COPY public.archive (id, information) FROM stdin;
    public          postgres    false    217   �[                 0    24757    booking 
   TABLE DATA           K   COPY public.booking (customer_ssn, room_number, hotel_address) FROM stdin;
    public          postgres    false    219   �[                 0    24760    chainphonenumber 
   TABLE DATA           P   COPY public.chainphonenumber (central_office_address, phone_number) FROM stdin;
    public          postgres    false    220   \                 0    24763    customer 
   TABLE DATA           u   COPY public.customer (customer_ssn, register_date, customer_full_name, customer_address, payment_status) FROM stdin;
    public          postgres    false    221   9\                 0    24768    defect 
   TABLE DATA           P   COPY public.defect (room_number, hotel_address, defect_description) FROM stdin;
    public          postgres    false    222   V\                 0    24773    employee 
   TABLE DATA           e   COPY public.employee (employee_ssn, hotel_address, employee_full_name, employee_address) FROM stdin;
    public          postgres    false    223   s\                 0    24778    hotel 
   TABLE DATA           `   COPY public.hotel (hotel_address, central_office_address, star_rating, hotel_email) FROM stdin;
    public          postgres    false    224   �\                 0    24784 
   hotelchain 
   TABLE DATA           ]   COPY public.hotelchain (central_office_address, email_address, number_of_hotels) FROM stdin;
    public          postgres    false    225   na                 0    24790    hotelphonenumber 
   TABLE DATA           G   COPY public.hotelphonenumber (hotel_address, phone_number) FROM stdin;
    public          postgres    false    226   wb                 0    24793    manages 
   TABLE DATA           >   COPY public.manages (employee_ssn, hotel_address) FROM stdin;
    public          postgres    false    227   �b                 0    24796    renting 
   TABLE DATA           Y   COPY public.renting (room_number, hotel_address, customer_ssn, employee_ssn) FROM stdin;
    public          postgres    false    228   �b                 0    24799    room 
   TABLE DATA           �   COPY public.room (room_number, hotel_address, capacity, view, price, extendability, booking_start_date, booking_end_date, room_status) FROM stdin;
    public          postgres    false    229   �b                 0    24804    roomamenity 
   TABLE DATA           M   COPY public.roomamenity (room_number, amenity_id, hotel_address) FROM stdin;
    public          postgres    false    230   �k       '           0    0    amenity_amenity_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.amenity_amenity_id_seq', 1, false);
          public          postgres    false    216            (           0    0    archive_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.archive_id_seq', 1, false);
          public          postgres    false    218            V           2606    24810    amenity amenity_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.amenity
    ADD CONSTRAINT amenity_pkey PRIMARY KEY (amenity_id);
 >   ALTER TABLE ONLY public.amenity DROP CONSTRAINT amenity_pkey;
       public            postgres    false    215            X           2606    24812    archive archive_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.archive
    ADD CONSTRAINT archive_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.archive DROP CONSTRAINT archive_pkey;
       public            postgres    false    217            Z           2606    24814    booking booking_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (customer_ssn, room_number, hotel_address);
 >   ALTER TABLE ONLY public.booking DROP CONSTRAINT booking_pkey;
       public            postgres    false    219    219    219            \           2606    24816 &   chainphonenumber chainphonenumber_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.chainphonenumber
    ADD CONSTRAINT chainphonenumber_pkey PRIMARY KEY (central_office_address, phone_number);
 P   ALTER TABLE ONLY public.chainphonenumber DROP CONSTRAINT chainphonenumber_pkey;
       public            postgres    false    220    220            ^           2606    24818    customer customer_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_ssn);
 @   ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_pkey;
       public            postgres    false    221            `           2606    24820    defect defect_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.defect
    ADD CONSTRAINT defect_pkey PRIMARY KEY (room_number, hotel_address);
 <   ALTER TABLE ONLY public.defect DROP CONSTRAINT defect_pkey;
       public            postgres    false    222    222            b           2606    24822    employee employee_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_ssn);
 @   ALTER TABLE ONLY public.employee DROP CONSTRAINT employee_pkey;
       public            postgres    false    223            d           2606    24824    hotel hotel_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (hotel_address);
 :   ALTER TABLE ONLY public.hotel DROP CONSTRAINT hotel_pkey;
       public            postgres    false    224            f           2606    24826    hotelchain hotelchain_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.hotelchain
    ADD CONSTRAINT hotelchain_pkey PRIMARY KEY (central_office_address);
 D   ALTER TABLE ONLY public.hotelchain DROP CONSTRAINT hotelchain_pkey;
       public            postgres    false    225            h           2606    24828 &   hotelphonenumber hotelphonenumber_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.hotelphonenumber
    ADD CONSTRAINT hotelphonenumber_pkey PRIMARY KEY (hotel_address, phone_number);
 P   ALTER TABLE ONLY public.hotelphonenumber DROP CONSTRAINT hotelphonenumber_pkey;
       public            postgres    false    226    226            j           2606    24830    manages manages_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.manages
    ADD CONSTRAINT manages_pkey PRIMARY KEY (employee_ssn, hotel_address);
 >   ALTER TABLE ONLY public.manages DROP CONSTRAINT manages_pkey;
       public            postgres    false    227    227            l           2606    24832    renting renting_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.renting
    ADD CONSTRAINT renting_pkey PRIMARY KEY (room_number, hotel_address, customer_ssn, employee_ssn);
 >   ALTER TABLE ONLY public.renting DROP CONSTRAINT renting_pkey;
       public            postgres    false    228    228    228    228            n           2606    24834    room room_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (room_number, hotel_address);
 8   ALTER TABLE ONLY public.room DROP CONSTRAINT room_pkey;
       public            postgres    false    229    229            p           2606    24836    roomamenity roomamenity_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.roomamenity
    ADD CONSTRAINT roomamenity_pkey PRIMARY KEY (room_number, hotel_address, amenity_id);
 F   ALTER TABLE ONLY public.roomamenity DROP CONSTRAINT roomamenity_pkey;
       public            postgres    false    230    230    230            q           2606    24837 !   booking booking_customer_ssn_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_customer_ssn_fkey FOREIGN KEY (customer_ssn) REFERENCES public.customer(customer_ssn) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.booking DROP CONSTRAINT booking_customer_ssn_fkey;
       public          postgres    false    4702    219    221            r           2606    24842 .   booking booking_room_number_hotel_address_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_room_number_hotel_address_fkey FOREIGN KEY (room_number, hotel_address) REFERENCES public.room(room_number, hotel_address) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.booking DROP CONSTRAINT booking_room_number_hotel_address_fkey;
       public          postgres    false    219    4718    229    219    229            s           2606    24847 =   chainphonenumber chainphonenumber_central_office_address_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.chainphonenumber
    ADD CONSTRAINT chainphonenumber_central_office_address_fkey FOREIGN KEY (central_office_address) REFERENCES public.hotelchain(central_office_address) ON DELETE CASCADE;
 g   ALTER TABLE ONLY public.chainphonenumber DROP CONSTRAINT chainphonenumber_central_office_address_fkey;
       public          postgres    false    220    225    4710            t           2606    24852 ,   defect defect_room_number_hotel_address_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.defect
    ADD CONSTRAINT defect_room_number_hotel_address_fkey FOREIGN KEY (room_number, hotel_address) REFERENCES public.room(room_number, hotel_address) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.defect DROP CONSTRAINT defect_room_number_hotel_address_fkey;
       public          postgres    false    222    222    229    4718    229            u           2606    24857 $   employee employee_hotel_address_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_hotel_address_fkey FOREIGN KEY (hotel_address) REFERENCES public.hotel(hotel_address) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.employee DROP CONSTRAINT employee_hotel_address_fkey;
       public          postgres    false    224    223    4708            v           2606    24862 '   hotel hotel_central_office_address_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_central_office_address_fkey FOREIGN KEY (central_office_address) REFERENCES public.hotelchain(central_office_address) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.hotel DROP CONSTRAINT hotel_central_office_address_fkey;
       public          postgres    false    224    4710    225            w           2606    24867 4   hotelphonenumber hotelphonenumber_hotel_address_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.hotelphonenumber
    ADD CONSTRAINT hotelphonenumber_hotel_address_fkey FOREIGN KEY (hotel_address) REFERENCES public.hotel(hotel_address) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.hotelphonenumber DROP CONSTRAINT hotelphonenumber_hotel_address_fkey;
       public          postgres    false    226    224    4708            x           2606    24872 !   manages manages_employee_ssn_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.manages
    ADD CONSTRAINT manages_employee_ssn_fkey FOREIGN KEY (employee_ssn) REFERENCES public.employee(employee_ssn) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.manages DROP CONSTRAINT manages_employee_ssn_fkey;
       public          postgres    false    227    4706    223            y           2606    24877 "   manages manages_hotel_address_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.manages
    ADD CONSTRAINT manages_hotel_address_fkey FOREIGN KEY (hotel_address) REFERENCES public.hotel(hotel_address) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.manages DROP CONSTRAINT manages_hotel_address_fkey;
       public          postgres    false    227    4708    224            z           2606    24882 !   renting renting_customer_ssn_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.renting
    ADD CONSTRAINT renting_customer_ssn_fkey FOREIGN KEY (customer_ssn) REFERENCES public.customer(customer_ssn) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.renting DROP CONSTRAINT renting_customer_ssn_fkey;
       public          postgres    false    221    228    4702            {           2606    24887 !   renting renting_employee_ssn_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.renting
    ADD CONSTRAINT renting_employee_ssn_fkey FOREIGN KEY (employee_ssn) REFERENCES public.employee(employee_ssn) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.renting DROP CONSTRAINT renting_employee_ssn_fkey;
       public          postgres    false    4706    223    228            |           2606    24892 .   renting renting_room_number_hotel_address_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.renting
    ADD CONSTRAINT renting_room_number_hotel_address_fkey FOREIGN KEY (room_number, hotel_address) REFERENCES public.room(room_number, hotel_address) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.renting DROP CONSTRAINT renting_room_number_hotel_address_fkey;
       public          postgres    false    4718    229    228    228    229            }           2606    24897    room room_hotel_address_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_hotel_address_fkey FOREIGN KEY (hotel_address) REFERENCES public.hotel(hotel_address) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.room DROP CONSTRAINT room_hotel_address_fkey;
       public          postgres    false    229    4708    224            ~           2606    24902 '   roomamenity roomamenity_amenity_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.roomamenity
    ADD CONSTRAINT roomamenity_amenity_id_fkey FOREIGN KEY (amenity_id) REFERENCES public.amenity(amenity_id) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.roomamenity DROP CONSTRAINT roomamenity_amenity_id_fkey;
       public          postgres    false    4694    215    230                       2606    24907 6   roomamenity roomamenity_room_number_hotel_address_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.roomamenity
    ADD CONSTRAINT roomamenity_room_number_hotel_address_fkey FOREIGN KEY (room_number, hotel_address) REFERENCES public.room(room_number, hotel_address) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.roomamenity DROP CONSTRAINT roomamenity_room_number_hotel_address_fkey;
       public          postgres    false    229    230    229    4718    230               g  x�eSKO�0>���EʢM�,p�!D%��.*�^g���ؑ����c�p�-��񽲅7u�G�����c���d�;�����l/;��Q��Aee��4d�rUc(�۴
ȇv9b���s[��1De� v�6���˓�w�+x�0J��zP��^�b{\��6�N�kxs'4��Qq�1
9����I�A�}�\�W����<3$Qnᙧ���^�%���O�'̴�4;W0	�R$g��q�9�/��/DY�a�`B�F�5���#n��Ɖ��h���ZF+Jf��Q�Fe,{8�jJ³FG�	�+���G!��������K���`e��$�֣(o��6O$�����g�������(ۤ��XB�DEž�4���O#|��D�������҄EU�3�{���Au��g(�\������tQG��W{x"�?R�B!/�k�A�6��+�9=��K�J���2�ΰ[��:����|�p��S��Փ#Z'j7͆&���ͧ\���JT�p�Rm�GTo�w6��\��U�%�,}�ؤgT���i1fc���f"����˹��E�{Q�����z5��H�E}š��W��&+�9R���zw���N�/s.�ˊK            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �         �  x����N#9���)� J�N�6av ���i��8i������N6<�T:�61i���﷫�2ݮ�.�3E�i]�J�Y��Ȍ�;�s���y�E�*t����&�����_�p����)Q'�	���#���D�����X�v��������4��1[�t'$\���bIE[�a	��_p�AC��0Z��
���0��3�($��5%�BIϠ��%�Pj�4D/�O�Ѓ/I���00h��&M��x��<l&{�Z��%���5����`�^���B�d�U���߶�fK��#��"��rES&�.)c
M����x��5�r�$ߤ��Vm�;!.�؆��IN��㐩m�	���^�ɗ���AO�K�F��!ѫ�y���5	��q�;����Fr����m� ��h}gBҷ�p-2N�^1%J����봏����X.�Օ��'��-"�i���"����EB|���"��n��zV�1��u-�-�Z�%�H��I�$���`ʠ)��[���%��"e>���:Pz��DQ|$9���6㊤E���&8�s��)�0W���;�vM��˰��)��w�>��H�����J,gB��Ɯl;h���ꈋ��f2�^B4�*���y��nh�L�Q��"�xM��f�"֣�J���*oCiR
8�v-��h�rH�o���6#�gО�l��-���"c�E�����ņCD�&h�!9��<��y=�o�Bm�I ��p������V�-.�.\U�ӘV���*��xrL�݆U�n�/�=*h°��o��"|�� �P-i�#Fr��6�叴��Ȼ,�0F�ȝ�~h��{�;�7�d��H�\M��K��!7e�ǰ}#6Ү��X?F���A15�⩪.�ŸruCm�P�"��
��k��|¡	p�Rh��P0&Tf�s��0|W��"�Z��b��}�;ˑ�[ȁ&P�����5���u�po?������5kF����y����X�\q}.ڋ��P舉,�A=�wb������0?�+��G��:��f���0M�@0e������%~��ì������r�&cqϯ��6;�B-��B�`�Hr2T=w?��T���k��b�̔rI��j���"7+�=I1�:S,����њ@�ⳌA�erI�I�����)��3.$!.�Q��4�A=B�`I"����V(�ux��Ɔc�h�M��1��g�����IJ�         �   x�m�MKA@ϝ_��,(���
�E���%�����f2V�띝��C!��=ޤ��C@i�!�z��<W�D{x��u��
��64�3��^���F�W#���sw7P@���}�G��E���ґ�X�-z�iƓf��h(ڹ[j�H?)��E��KƁ+���=�
�&t��p���L� h���ho�C��M�ItД��O�K�N����!4�"ų2�}�Z�a`�.������#��g��6��            x������ � �            x������ � �            x������ � �         �  x����R�8���S�2S>�p���3�T���,�
cS>��<��IH�H�`��-����I�-9L0����"+�z�E^�RdC�{#����;�H� ��z��Pr6����A��;?z��oC���yT2=Av<8/��*_��%�v�O6����hp&�����n�ц��D����G/>^}���<��gQ�rE��C��3����_�_�'�2q�ɃCW�}��EZhX���%g�?Ey����\�2��[Բ�z�Ka�2&��E���hk�^l���dk��/e�
'E�-�������]k�u��Z��w�hI=ΞҡwU�z[C�T���[���1�˺�"�fzb�{���;�y{�.�x��e#q�I
��J�]���ɒ;y�Cﬨ�I~'3Y��#S�E�+�r���.�*��%4]�'�H��%ޘ�m���x$<x�%<1u"#ZYݨ�{�$�I~Y��K&>MG�i��QWlb����n)5����P5x&v�R"���M���pK���x���Ȯo�@#�x��O6����f�|�k1��O$���M�> �� �
���SJ���`p���,�RЩE���s���C	%�ɡ���+w��k�h):�g��~�;Q�	�I��ײL����,�Y��Q����6?�>>�Rd��a_�X����!����8.����oٕ��&��`��@�R�1n8Z��7<ϼh�;<n�u�ã���@�x�Y�\�&�|��L5���W/`<��p.�����D� 3@�/���p3?5�K�F����q�t���^	���(��q\ӟ	4L��C���
��C><� ��'ި0��(-ԧ���ߦ��2��j�}ʊR�֞$�7Z�@�F��1�D,Ai�̽x3��.:	a`����*	P��虺Hն�癤�pQI���@я�P�����H�o�-	!\\��ے4t�$Jؖ����I�ޱ7�Wߜ�H��Vz4x�r��̙$��h�Z��o��^����?��l�F(���AYF
�F-X���M�"U�\&�c��m|��E.+����˿�A����p�ǅ����&�d�H�Ǣ��Y��]v��'����F��F�]�5a�vƑ������U�ӂ�>�*E~#���Lu)0fr�z0c���E=�1�uQ.R��<��|�M���'u�}�l�:���6����e�S�{��U��ٔ��.g��-�U)���|-v��pA~��w��d9��"N�Z��xh�!���n�Q�C2�C��@��P ^���;��_Z��͵P��zR�k��*]N��'XJ�,Q��DҔ�"c�s��.r�x��U1��V.�z�Mn���׫ڥpxX��E0���[O�"�~o�̫z�l������
�]���a ܉�4��ssO|S��ȍƷʍ�I.mc�Ç��m��=e_P����
�oP��;`&�f�	�#]��{��7�yE�6�$Zq)LB��������ty;s2Յ��z�Y��x��K�����dM�n�d�~ Z�.h��P�Y�I�.���`�m�_�E�hӔ�y�u[_�"
�3��wA � �������ו���Ș����� ۃ����eu�jp�lyFP���Ac����q"�=��d�h�׊���G!#���ARY��e�ᛝXBVl�x��a��'���e�,7z&Cg'�YJ���vJ� T(�
ی��੉���(�y@�4,n�ƅO��>�l�w�"�E��	�޽�@���� �u3�Y�6��u�������bl�݇���,j
�����q�S5<;&�Kj₧@3�`�6x��ݴyU���N�C<��=���.�a?�<�GEg�Ā��h;�����M= ���aVz��p-���k��R���R�Z�q)~��۶Al����T�l�׽�B�����%����' �v3��Z<e� |kp�B
'�ŉ2HX_�K�S��M[�>b��C��mE�Y���+�wS�yQ�3�R��bl��t�糌t`*�D!T�d+5^��������Ot�L��}?�u��Q7��V�ȯ�Lw�My/��n��Tw3=�[0x�e{P���v��S�����RJ�1�Bu�`#�l��z0s�x�Me?�a�h�d��oQZ�.���K|qb,�h+Ý��T��y&LL求L<)�(`i������?G�\            x��]�n#G�}��� ,��"�ض��]{=��`�}�nq�D�I������aE�dy֮8�`�uNFd�22+��V��6�������w7�oΧ��a��Y�������f��xo���j#��&�2�'U�A3n��B�j��yCj��*��*�
����P4��*7������g|Vh �>&��/ 7�
#����۪�Nm��nֆ�J�3�
E�� EC��~m��2�*���h	���������Հ��.,�*~�'���
���˿ ���i������������p{���p��V�$p*ϱ�g9E�(6��,��f]�QL��QB�6[擽�r��T�+A�$pl5$9��yE[^�)��|�S!G_�{�Lq*_q�vg����BN��䤽����|kEr����F�CsA�A�A(���m���Ю�Ƙ�Ъm� �
-�Vh=�B����VX�Z>��8��no�oΗ���|����0^��'n{�`�oD��Q�B	{K�b-�P0�>������آ0�+�֭`��DQa�WV�ʅ1F�4���h|~���g>��1*���qv%jQ��Xe�%D�L�6&�3�FT��&pɟb�:��-�X<�2���S���������
���FR��$9�6A�j�r���B�/{$'	r-��,�Ç[­/D$�.:MѦ�����������O2H��mE�h�+NRќ��������������~Z���8_N��wV�iѭ1��ܩD�*MYY�2E]��Mb&Ѳُ4�{�Y�p/r��{!�̍��RV��jVW_�5��}U��jAhr 4��49j�{�^b��g+|s��Ӓ�$EN�9O���y����Z8,��F��fM���{�C�Zb���'�n�_8s'�{��Q�0�P���O�1(1jBu���A7���CqMQ_<����h_�1�t�����a+-�[�,@f�!3>(��zَ��6�c.!9Y�-�m9,�_#9���ơ�ӷr,�vOB�_{b�<g�Rꊎ�&x��0l�M���R7�}x?����e@��})��VK0d��	��O��j�C~��,�y� �1Q .���m��s��
l�~� ��z�c�Q�t Y��B�c�@���w\���5+�~��Za�U	�͌��-�O� $���O�kvÅ�QԈuz���š�̦a���NE�B��b� ��z���Yx�-�%��c�t�ЩV�X����X�
]�V�1���c+�V�Ph�Mֈk�Լ2�x!̜D�)�{Q�E��ǟ�JDU� �T=5�����k��&�2��q�xb�YC+񲪨LԜ�ͽD�L��dG"�N�{W�@��MM��jIDu��5e��7q���;�0�Ogz?]��߾@LR�4cO2�(��X\��Oa��G��/�%���5�cX!�(�������[$�Rx!��+`^�I�
�/��-�Ob���R���x��+���ƧdS���4�+q$�_���jJZ����2����~��
~-�H�@��+���Lm��t��2��(G�i_N�'��=gfjK
�&���F��4Zun���Ѯ�R��88�;�����6�?��k�&�R֤I����V�Q�Rhe��X5a�˅ m'�6˖A�A���RR�ia�V���KA
M
�&�:y�.�4�n�����F.K�\��]�����ri�iɜ��RA���r��.1v]��U��Q�zl�%�ټ	R�y���ܖx�^[N��L�N�-�En^�Mt�*��wu�@������ک��),r��ʋTt�jZ��rPe�[T���zSV�t�JN��[VUc�Rŷ&"WV�.���R���o�T�ߟ���V�������������F��酿��B�+WѺ��V?ד�M�<_oڿ�q��̶^WfK�m	y��y��6�؋fmYdg���N��X��`�eQ��r$�ӂX�w���_�DXf/P�o�e����Q&�Ez/�~��U4������k�4͡<�vc,��.xZV���h���A�VVK��W(���TT���A����,�XPR�V�2R��h�ܪV�V�)���67%٪�U+?}���D;j�":[�?Msv��)&�� M�$��h�ߚV���`�o�L�ۈ�D��b��e�H���XY��I�)^�+EG�,xVV�XD��hJ`��^�)N���J���H����G�&�u[���5��4�<Z��~u\<�S�A[b����Fo��3��V0�
FS`b��2_ߧ�hrl���^:�&<�{_M���v�a4��mEMimk�f����F~lT���(y��_?�����~j��q�x�Y���|9��۠%	��sKɂ�'�ɴ٦����K��y�Z3[�x�h���v"Gr�k�4��1]%�hT���F<�V�	�Ӧu�����L玝��s���r����{��5�0�(F�K(�VjOO<��-�fX@0��&�H�q�G"'���ٗd�A����(tz��� ��x��1HS69��>���J�T�)O;T	c��XNJ�4��ERXŊ�8J⥰&.���Y'K�}�a�1h�T/��T�ٳ��ޟ��M���1y��O;��k��H,c��i��6��,�2�b����e����V�4P�D32��~��ƭ�Y��AI(���e���X�6/�#�QJ[��0�^�Sן�w�B,"��I�J�l�=^%�6��i+w"�h~�b�e�7�����զE�bQ��WF���k+�2�2�X�Tl�<KD�6I�������_�?~8\k�����n<���`�2:fc2��� ������|4L��w�d D��ɀC}G�E�̪��`R�r/�fCB���M<tCR�����C}*�OZc#W�1F��a L9իw$
�����Հ<o������H0N	�I��K�p�l�/������9��w��W����0�����03@�
�0����XH�0�-ycTa	�!���hʚ �x*C��+TCPY}[�s{'����
�0{@�R��`�LRb�[â�A��K2 �U_� &�˻�w���Ã��}>^��Χ�������a~�˓P�	���j�Bf���yI�ɱ�]X�0�)}OjK�{�qT@��B�Y���8O*o�REtjHP��������!�|Sni���?��Aѵ��o����w����6 h`"���yP�H	A j�@1��-���r�h
A�-�2k8Pl��H1fj��z��q@4��(�ސ h`�]�w�a����|�]�w?ߞ?߬_=�?\��J�iZ�AP�PS}BC}�������0C�ɐ{�0V�Ƃ$����z�T�)�W!�� /�A��>\�� sU�\^�c`-;�C�-��A.lHiP�{]����i����Q�����/����w���<\�N`d"������Ȍ�O��Ss�B�@���k6��g< �e;tP4 2� ނCЂ�ʗ�Qܪ~���g�`(W��
ו�gk�}�WEpT�Y���cЌz���jTi�F���ǟ�O���ۿ�x�p�܎�O><�w���F�8:����3��)��JЮ��`���0���"56c���0��z�3����������o����W������W6Iƞf�X�t��0���a�
� �i9��"g(��kE����(������QX�l*��qz��42�����F���t�?��
��H]�����M�b��~s�t�64�Ǉ��W���7�S����v�9��<!Xz���(r�3jL�-�!3h�GG�� ��q�OQ1$D��:���_j;�@�-6&,$�t15AW686�fB��l�^cHК�Q�s��S�6����A3��aef������xz�'߀���p8�?|�������n�����̎�'R�7�<Sp�%N�R��9]�'��K+gF1�=Q��)�8e�T��{h��⅜'^��L޸X�����L�7ZwN���s٤�kS���ܔ���u)[@��d{F 3  ���)�ɂJ����ܲ����v�ly��Ew��d��~yAlN�pu7�IaurA��B$O��t[�5]�D�V��b�Nm:��A�/�����W����25�*ۛi����rX�U��@���Yo�;e�x�S�,�Ǣ��Tt��5���/re��"���nV�bUS�iP���J�t�)S4'����������,Y�-̔�`�EH�J�]��e5b��e�	(����(�R��\X����ts�\R���B#����H�66�}���k!��M��ͧ�����2�����7����Z����%�Vb5��4�hEX��e�g�KOS|�7k��;MZh�Ӌ�)�.���i���4+M,���,�i�i�NVE�������//��F%�@��vv	!+<$��FZǋ!��g#�̠+�X�a-�L������,��
I�w��`U/hؐ0�xE���1l�%@�ge��ӟ�@HИ��ń�ţ�3��<Q�~��r������V"�	���\�)�-xq��dG��41t�\�хP�P�=;�� �^|مє�54���J�Jy�z��	�����o�p4~W��T�ߟ�����������{�4a�%ˠ	�4&��F.1���O/g�Χ�,�BP@	g�i(. k�B��>��AB��c�w�Ȗ�`b�`j�D���v��#4Q�e��U��I����F,���۟�C�A���S�0(��~�+�8$$	����H����ww��ݭ�����K8�#b�g���T��_�1�����x�pʩ���8�03�\�љ�K8E�ΩN9�Y�sp2Q��Uݤ����S����������/k��Ѯ���m4^ŉ���E��5t���	�&9ϮzJ<��Y2������H<Q\�hR�(����L�Rʼi���)z\�����xZ����_��I<��UK�*���e�m6�u?O�<��M�_��.j/0��/�X�^!%�U�$k'�2Ϛ�+$���jMJ[�%�=�$�F�$x8{:����.��B*K��MYH����R�Q�,)����Ei�2���<K�"���+ɪ�W#Ym%Da�M6�R���U�<��{Ծ�pAHa�xjp+%�zY��(%����Ì�ʞ�RIJ]�^�����d�~������-���F�X�p$��;���V�	$k�YRV$�ZC�7$��}ǒ���$�ÇC��4)	-��!G������֒��(Jթ�zu����<��;�)�J���˛��|z�Ҿ==���yz�voǧ>�7�[omM 18�y��pƌ���pR��K����'Ύ��vd��{E��T��0�!��L|��/
���*;z&�aS9�W_+p��B��H��������+ 1: �2z��H�0m+n�T�7*p\�+��//�w_���~���O?ܞ?>��@h���q]m�����q��mU�Y�@��:��K
�C��È�[3Ñ_�-^N1(�~I�O�
�&4�+�OҊ{�w4 �����vm�]^��?ku�����(=W��W���������Cl��@�1$ź�ͨ?| �.}�3	MW�I�B�Y׏��C��?��Rc�QS�Id���Hd�^oH�hqL������p����Qbm��ҳ{y�����kc�����������, [<��}��j� R G�y+e_�f�4�� ��
�s�B���,`~�)Y�`(��������9��� �$kd�d?��̇[�r�v���xnQ�5oV� ���Y��,�~��=�m0C(b>��������"7`0[�C�?�a�Yv��٤z_ �@d:�W��
h;p�P<�:�<� 䰞.rE?%q�[I���������p����x�����ǻ~�Bad��Se���� �>�Aj)o8Pp$>�=>)\>>'�SNj���*P`U�^M��8u�o�!h���~��¹R�\��B6��U�B3Z���wkÓ��jp�hx^���(-k��>��/��xTe|V�Zi��KZv�1�e�6�`+��	�>'j�=�2���%W�p���7.��8�L8�[�06�ζ�>0n�����:0��r�)�Ȓ�#�`�#����^���n�Cc��$jc��1aߘRۘ����ϯMMGQ_>���4_]Ʒ�?|<^^�r@��8x"��rpRy�Ҙ���3�B�a�� ��s���HO9ןl��B��6���X�+����[<f��>���S�P�d�d8�]Wj|r��:���w�����y�q�����+�����x���D����4�+11j��2����Q;U���] *!��,OT?=QpP��x�@s�kE��h�,QA��U+}���2zB��gtP6ο��cD�!���C<
 ل3_ 	�|��-$�N��yH|S:G.�+#"ӳxz�ו Y�>i���<� �(5��<A/2�`�J��Nlh�<��b[�����0�����s�M�w[�g%�r ����J�C$b^B&=�`�L~�x^������"e>r9�u/ų�H��$��p0�AY��k�15�C�آ���1�� {��[�	ӂ�㇨�S�l�-;�{~#b�X}u�0��>�ݬ�<^>��>7�A�)m ��.!# &!z#% �GƉA1d�M"0�IBF���  ����2Sl��;E��b��&4�)N^?����{Q��������^=�?��o����>���3BPB0��2.���4d�xj~�+�X�F���".A� Ll$�*�󏃭1�S;Ł�`��xnȑ�8�"��`h�x���?z�@��{m�@q4�o�I������i��xzw~��py�=�!��̚!���dH�-4AH^�Aًa�Bl�oP�ca(H{�Z~
� �TĢ�_�B�k^,C.�H��*���m 
P��a��N�;t���#����D��Ő}�5����i�� ���XP4H���{�y�u��(5�ĈЅ���G���xE�Ī��;�9HC ���j�bH��P��ĊĈ(	��?>�����:     